import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  const AppTextField({
    Key? key,
    required this.controller,
    this.labelText = "",
    this.hintText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "$labelText",
          hintText: "$hintText",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
