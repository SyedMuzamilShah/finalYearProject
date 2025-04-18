import 'package:flutter/material.dart';

void showMyDialog(BuildContext context, Widget child, [bool isLoader = false]) {
  showDialog(
      context: context,
      barrierDismissible: !isLoader,
      builder: (context) {
        Widget dialogContent = Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4,
              minWidth: isLoader ? 100 : 200,
              minHeight: isLoader ? 50 : 200,
              maxHeight: isLoader? 80 : double.infinity
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
      });
}
