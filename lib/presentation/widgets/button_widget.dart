import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tentwenty_assessment/presentation/widgets/text_view_widget.dart';

import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/dimension_resources.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.buttonText,  this.filled=true, this.icon, required this.onTap});
  final String buttonText;
  final bool filled;
  final String? icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: Dim.D_243,
          height: Dim.D_50,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(Dim.D_10),
            color: filled?Colorss.CURSOR_COLOR:Colorss.TRANSPARENT,
            border: Border.all(color: Colorss.CURSOR_COLOR)
          ),
          child:  Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(icon!=null)
                SvgPicture.asset(icon??""),
                if(icon!=null)
                const SizedBox(width: Dim.D_10,),
                TextViewWidget(
                  text: buttonText,
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colorss.WHITE,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
