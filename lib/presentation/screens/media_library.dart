import 'package:flutter/material.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';
import 'package:tentwenty_assessment/presentation/widgets/text_view_widget.dart';

import '../../helper/constants/colors_resources.dart';

class MediaLibrary extends StatefulWidget {
  const MediaLibrary({super.key});

  @override
  State<MediaLibrary> createState() => _MediaLibraryState();
}

class _MediaLibraryState extends State<MediaLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextViewWidget(text: Strings.MEDIA_LIBRARY, textStyle:  Theme.of(context)
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
