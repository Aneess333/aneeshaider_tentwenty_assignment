import 'package:flutter/material.dart';

import '../../presentation/widgets/text_view_widget.dart';
import '../constants/colors_resources.dart';
import '../constants/strings_resources.dart';

class DialogUtils {
  static Future<void> showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextViewWidget(
            text: Strings.ERROR,
            align: TextAlign.start,
            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colorss.COLOR_BLACK,
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: TextViewWidget(
                text: Strings.OK,
                textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colorss.DARK_BLUE_COLOR,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
