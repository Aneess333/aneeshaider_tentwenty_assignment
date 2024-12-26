import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_assessment/helper/constants/colors_resources.dart';
import 'package:tentwenty_assessment/helper/constants/dimension_resources.dart';
import 'package:tentwenty_assessment/helper/constants/image_resources.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final Function()? onClose;
  final Function(String) onSubmit;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmit,
    this.onClose,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmit,
        textInputAction: TextInputAction.go,
      style:
          Theme.of(context).textTheme.labelLarge?.copyWith(
              color:  Colorss.DARK_BLUE_COLOR,
              height: Dim.D_20 / Dim.D_16,
              fontWeight: FontWeight.w400),
      cursorColor: Colorss.CURSOR_COLOR,

      decoration: InputDecoration(
        fillColor: Colorss.FIELD_BG,
        hintText: Strings.SEARCH_HINT,
        filled: true,
        hintStyle:  Theme.of(context).textTheme.labelLarge?.copyWith(color: Colorss.HINT_TEXT_COLOR),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(Dim.D_8),
          child: SvgPicture.asset(
            ImagesResource.SEARCH_ICON,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: widget.onClose,
          child: Padding(
            padding: const EdgeInsets.all(Dim.D_8),
            child: SvgPicture.asset(
              ImagesResource.CLOSE_ICON,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.D_30),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.D_30),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.D_30),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
