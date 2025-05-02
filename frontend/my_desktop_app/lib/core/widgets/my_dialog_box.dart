import 'package:flutter/material.dart';

void showMyDialog(BuildContext context, Widget child, [bool isLoader = false]) {
  showDialog(
    context: context,
    barrierDismissible: !isLoader,
    builder: (context) {
      final size = MediaQuery.of(context).size;

      Widget dialogContent = Dialog(
        insetPadding: const EdgeInsets.all(20), // Small margin from all sides
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.95,
            maxHeight: size.height * 0.95,
            minWidth: isLoader ? 100 : 300,
            minHeight: isLoader ? 50 : 200,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      );

      if (isLoader) {
        return PopScope(
          canPop: false,
          child: dialogContent,
        );
      }

      return dialogContent;
    },
  );
}
