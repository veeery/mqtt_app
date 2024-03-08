import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final Color color;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 90.w,
          minHeight: 8.h,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: color,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Center(
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 4.w,
                        height: 4.w,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 0.6.w),
                      ),
                      SizedBox(width: 5.w),
                      Text('Loading', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                    ],
                  )
                // : Text(text, style: kBodyTextBold.copyWith(color: Colors.white)),
                : Text(text, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          ),
        ),
      ),
    );
  }
}
