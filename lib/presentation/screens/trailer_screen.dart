import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tentwenty_assessment/helper/constants/colors_resources.dart';
import 'package:tentwenty_assessment/presentation/widgets/video_player_widget.dart';

import '../../helper/constants/dimension_resources.dart';
import '../../helper/constants/image_resources.dart';
import '../../helper/constants/strings_resources.dart';
import '../widgets/text_view_widget.dart';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.DARK_BLUE_COLOR,
      body: SafeArea(child: Stack(
        children: [
          YoutubeVideoPlayer(videoUrl: widget.videoUrl),
          Positioned(
              top: MediaQuery.of(context).padding.top +
                  Dim.D_20,
              left: Dim.D_20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                        ImagesResource.BACK_WHITE_ICON),
                    const Padding(
                        padding:
                        EdgeInsets.only(left: Dim.D_20)),
                    TextViewWidget(
                      text: Strings.DONE,
                      align: TextAlign.start,
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colorss.WHITE,
                      ),
                    )
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
