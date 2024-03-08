import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;

  const AppTextField({
    Key? key,
    required this.controller,
    this.labelText = "",
    this.hintText = "",
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ]
            : <TextInputFormatter>[],
        decoration: InputDecoration(
          labelText: "$labelText",
          hintText: "$hintText",
          labelStyle: TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
          ),
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(2.w),
            ),
          ),
        ),
      ),
    );
  }
}
