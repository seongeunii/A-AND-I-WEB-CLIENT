import 'package:a_and_i_report_web_server/src/core/widgets/bottom_logo.dart';
import 'package:a_and_i_report_web_server/src/core/widgets/logo.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/basic_report_view.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/framework_report_view.dart';
import 'package:a_and_i_report_web_server/src/feature/reports/ui/view/cs_report_view.dart';
import 'package:flutter/material.dart';

class HomeMobileScreen extends StatelessWidget {
  const HomeMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 사이트 로고
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 22.5),
          child: Logo(),
        ),
        const SizedBox(
          height: 10,
        ),
        // CS 과정 과제 목록
        const CsReportView(),
        const SizedBox(
          height: 10,
        ),
        const BasicReportView(),
        const SizedBox(
          height: 10,
        ),
        const FrameworkReportView(),
        const SizedBox(
          height: 50,
        ),

        // 사이트 하단 로고
        const BottomLogo()
      ],
    );
  }
}
