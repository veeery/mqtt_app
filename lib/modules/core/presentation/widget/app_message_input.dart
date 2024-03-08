import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  final String labelText;
  final IconData iconData;
  final bool isLoading;

  const MessageInput({
    required this.controller,
    required this.onPressed,
    required this.labelText,
    required this.iconData,
    this.isLoading = false,
  });

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  void _sendMessage() {
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(3.w),
                ),
              ),
              suffixIcon: widget.isLoading
                  ? Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: SizedBox(
                        width: 5.w,
                        height: 5.w,
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 0.6.w,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(widget.iconData, size: 25.sp),
                      onPressed: _sendMessage,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
