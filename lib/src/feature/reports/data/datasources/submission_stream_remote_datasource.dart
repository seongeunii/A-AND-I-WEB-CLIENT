import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:a_and_i_report_web_server/src/core/constants/api_url.dart';
import 'package:web/web.dart' as web;

/// 제출 결과 SSE 스트림을 연결하는 원격 데이터소스입니다.
class SubmissionStreamRemoteDatasource {
  /// [streamUrl]로 SSE 스트림을 열고 `data:` payload를 순서대로 반환합니다.
  const SubmissionStreamRemoteDatasource();

  Stream<String> connect({
    required String streamUrl,
    required String accessToken,
  }) {
    final controller = StreamController<String>();
    final abortController = web.AbortController();
    web.ReadableStreamDefaultReader? reader;
    var isCancelled = false;

    Future<void>(() async {
      try {
        final resolvedUri = _resolveStreamUri(streamUrl);
        final response = await web.window
            .fetch(
              resolvedUri.toString().toJS,
              web.RequestInit(
                method: 'GET',
                headers: {
                  'Accept': 'text/event-stream',
                  'Cache-Control': 'no-cache',
                  'Authorization': 'Bearer $accessToken',
                }.jsify()! as web.HeadersInit,
                signal: abortController.signal,
                credentials: 'same-origin',
              ),
            )
            .toDart;

        if (!response.ok) {
          throw Exception(
            '채점 스트림 연결에 실패했습니다. (${response.status} ${response.statusText})',
          );
        }

        reader = response.body?.getReader() as web.ReadableStreamDefaultReader?;
        if (reader == null) {
          await controller.close();
          return;
        }

        var pending = '';
        String? currentEvent;
        final dataLines = <String>[];

        while (!isCancelled) {
          final chunk = await reader!.read().toDart;
          if (chunk.done) {
            break;
          }

          final bytes = (chunk.value! as JSUint8Array).toDart;
          pending += utf8.decode(bytes, allowMalformed: true);

          final splitLines = pending.split('\n');
          pending = splitLines.removeLast();

          for (final rawLine in splitLines) {
            final line = rawLine.trimRight();

            if (line.isEmpty) {
              _emitEvent(controller, currentEvent, dataLines);
              currentEvent = null;
              continue;
            }

            if (line.startsWith(':')) {
              continue;
            }

            if (line.startsWith('event:')) {
              currentEvent = line.substring(6).trimLeft();
              continue;
            }

            if (line.startsWith('data:')) {
              dataLines.add(line.substring(5).trimLeft());
              continue;
            }

            if (dataLines.isNotEmpty) {
              dataLines.add(line);
            }
          }
        }

        if (pending.trim().isNotEmpty) {
          final trailingLine = pending.trimRight();
          if (trailingLine.startsWith('event:')) {
            currentEvent = trailingLine.substring(6).trimLeft();
          } else if (trailingLine.startsWith('data:')) {
            dataLines.add(trailingLine.substring(5).trimLeft());
          } else if (dataLines.isNotEmpty) {
            dataLines.add(trailingLine);
          }
        }

        _emitEvent(controller, currentEvent, dataLines);
        await controller.close();
      } catch (error, stackTrace) {
        if (!controller.isClosed && !isCancelled) {
          controller.addError(error, stackTrace);
          await controller.close();
        }
      } finally {
        try {
          await reader?.cancel().toDart;
        } catch (_) {}

        try {
          reader?.releaseLock();
        } catch (_) {}
      }
    });

    controller.onCancel = () async {
      isCancelled = true;
      abortController.abort();
      try {
        await reader?.cancel().toDart;
      } catch (_) {}
    };

    return controller.stream;
  }

  Uri _resolveStreamUri(String streamUrl) {
    final trimmed = streamUrl.trim();
    if (trimmed.isEmpty) {
      throw Exception('채점 스트림 URL이 비어 있습니다.');
    }

    final uri = Uri.parse(trimmed);
    if (uri.hasScheme) {
      return uri;
    }

    if (baseUrl.trim().isNotEmpty) {
      return Uri.parse(baseUrl).resolve(trimmed);
    }

    return Uri.base.resolve(trimmed);
  }

  void _emitEvent(
    StreamController<String> controller,
    String? eventName,
    List<String> dataLines,
  ) {
    if (dataLines.isEmpty && (eventName == null || eventName.isEmpty)) {
      return;
    }

    final rawPayload = dataLines.join('\n').trim();
    final payload = _tryDecodeJson(rawPayload) ?? rawPayload;
    controller.add(
      jsonEncode({
        'event':
            (eventName == null || eventName.isEmpty) ? 'message' : eventName,
        'data': payload,
      }),
    );
    dataLines.clear();
  }

  Object? _tryDecodeJson(String value) {
    if (value.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(value);
    } catch (_) {
      return null;
    }
  }
}
