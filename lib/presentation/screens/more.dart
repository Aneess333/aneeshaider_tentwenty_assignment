import 'package:flutter/material.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';
import 'package:tentwenty_assessment/presentation/widgets/text_view_widget.dart';

import '../../helper/constants/colors_resources.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextViewWidget(text: Strings.MORE, textStyle:  Theme.of(context)
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
