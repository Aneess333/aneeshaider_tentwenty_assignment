import 'package:flutter/material.dart';
import 'package:tentwenty_assessment/presentation/widgets/text_view_widget.dart';

import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/dimension_resources.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.categoryName, required this.color});
  final String categoryName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: Dim.D_2, horizontal: Dim.D_10), // Padding// Width (hugged width of 60px)
        height: Dim.D_24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dim.D_16),
          color: color, // Background color (can be changed)
        ),
        child: TextViewWidget(
          text: categoryName,
          align: TextAlign.start,
          textStyle: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colorss.WHITE,
          ),
        ));
  }
}
