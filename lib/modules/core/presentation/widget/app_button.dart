import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 10,
                      child: const CircularProgressIndicator(color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    // Text('Memuat ....', style: kBodyText.copyWith(color: Colors.white)),
                    Text('Memuatttt'),
                  ],
                )
              // : Text(text, style: kBodyTextBold.copyWith(color: Colors.white)),
              : Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
