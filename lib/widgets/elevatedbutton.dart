import 'package:flutter/material.dart';

class MYElevatedButton extends StatelessWidget {
  const MYElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback? onPressed; 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Use the passed-in onPressed
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.green[400],
        foregroundColor: Colors.white,
      ),
      child: Text(buttonText),
    );
  }
}
