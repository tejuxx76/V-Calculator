import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function(String)? onTap;
  final VoidCallback? onIconTap;
  final Color? color;

  const CalcButton({
    super.key,
    this.text,
    this.icon,
    this.onTap,
    this.onIconTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 2,
      ),
      onPressed: () {
        if (text != null && onTap != null) {
          onTap!(text!);
        } else if (onIconTap != null) {
          onIconTap!();
        }
      },
      child: icon != null
          ? Icon(icon, size: 24, color: Colors.white)
          : Text(
              text!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
