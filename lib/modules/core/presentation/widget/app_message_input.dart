import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  final String labelText;
  final IconData iconData;
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback? onTap;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.labelText,
    required this.iconData,
    this.onTap,
    this.isEnabled = true,
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
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        TextField(
          controller: widget.controller,
          enabled: widget.isEnabled,
          onTap: widget.onTap,
          onSubmitted: (_) => _sendMessage(),
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(3.w),
              ),
            ),
          ),
        ),
        widget.isLoading
            ? Container(
                width: 1.w,
                height: 1.w,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 1.w,
                ),
              )
            : IconButton(
                icon: Icon(widget.iconData, size: 25.sp),
                onPressed: _sendMessage,
              ),
      ],
    );

    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: widget.controller,
            enabled: widget.isEnabled,
            onTap: widget.onTap,
            onSubmitted: (_) => _sendMessage(),
            decoration: InputDecoration(
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(3.w),
                ),
              ),
              suffixIcon: widget.isLoading
                  ? Container(
                      width: 1.w,
                      height: 1.w,
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 1.w,
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
