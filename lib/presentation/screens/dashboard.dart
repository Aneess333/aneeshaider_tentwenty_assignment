import 'package:flutter/material.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';
import 'package:tentwenty_assessment/presentation/widgets/text_view_widget.dart';

import '../../helper/constants/colors_resources.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextViewWidget(text: Strings.DASHBOARD, textStyle:  Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(
          fontWeight: FontWeight.w400,
          color: Colorss.DARK_BLUE_COLOR,
        ),),
      ),
    );
  }
}
