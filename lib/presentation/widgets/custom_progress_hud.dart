import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/dimension_resources.dart';

class CustomProgressHUD extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final bool dismissible;
  final Widget child;

  const CustomProgressHUD({
    super.key,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(
      color: Colorss.NAV_BAR_COLOR,
    ),
    this.dismissible = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        child,
        if(inAsyncCall)
        Opacity(
          opacity: opacity,
          child: ModalBarrier(dismissible: dismissible, color: color),
        ),
        if(inAsyncCall)
        Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator(
                    color: Colorss.NAV_BAR_COLOR,
                    radius: Dim.D_20.h,
                  )
                : progressIndicator),
      ],
    );
  }
}
