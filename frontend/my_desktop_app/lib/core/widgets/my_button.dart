import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String btnText;
  final Color? color;
  final Function()? onClick;
  const MyCustomButton({super.key, required this.btnText, required this.onClick, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )),
        // minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
        backgroundColor: WidgetStatePropertyAll(color ?? Colors.blue),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      onPressed: onClick, 
      child: Text(btnText));
  }
}