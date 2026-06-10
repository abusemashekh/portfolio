import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedText extends StatelessWidget {
  final String text;
  final AnimationController controller;

  const AnimatedText({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        int displayedLength = (text.length * controller.value).round();
        String displayedText = text.substring(0, displayedLength);

        return Row(
          children: [
            Text(
              displayedText,
              style: GoogleFonts.alata(
                fontSize: 32,
                height: 1.5,
                color: const Color(0xFFE2E8F0),
                fontWeight: FontWeight.w300,
                letterSpacing: 0.4,
              ),
            ),
            if (controller.value < 1.0)
              Container(
                width: 2,
                height: 40,
                color: const Color(0xFF4ECDC4),
                margin: const EdgeInsets.only(left: 2),
              ),
          ],
        );
      },
    );
  }
}
