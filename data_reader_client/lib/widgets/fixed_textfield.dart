import 'package:flutter/material.dart';


class FixedTextField extends StatelessWidget {
  const FixedTextField({
    super.key,
    this.hintText,
    required this.onChanged,
    this.onSubmitted
  });

  final String? hintText;
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[

      SizedBox(
        width: 450,
        child: TextField(
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ),
    ],
  );
}