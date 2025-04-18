import 'package:flutter/material.dart';
import 'package:my_desktop_app/core/widgets/loading_widget.dart';
import 'package:my_desktop_app/core/widgets/my_dialog_box.dart';

class MyAttendenceView extends StatefulWidget {
  const MyAttendenceView({super.key});

  @override
  State<MyAttendenceView> createState() => _MyAttendenceViewState();
}

class _MyAttendenceViewState extends State<MyAttendenceView> {
  bool isSelected = false;
  changeStatus(value) {
    setState(() {
      isSelected = value;
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () async {
              showMyDialog(context, MyLoadingWidget(),true);
              await Future.delayed(Duration(seconds: 2));
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: Text("Testing")));
  }
}
