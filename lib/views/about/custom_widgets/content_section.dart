import 'package:flutter/material.dart';
import 'package:flutter_portfolio/controllers/portfolio_controller.dart';
import 'package:flutter_portfolio/models/portfolio_model.dart';
import 'package:flutter_portfolio/views/about/custom_widgets/action_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animated_text.dart';

class ContentSection extends StatelessWidget {
  final PortfolioController controller;

  const ContentSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: controller.fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: controller.fadeAnimation.value,
              child: Transform.translate(
                offset: Offset(0, 10 * (1 - controller.fadeAnimation.value)),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00F5A0), Color(0xFF00D4FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: portfolioData.greeting,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 26,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 5),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
          ).createShader(bounds),
          child: Text(
            portfolioData.name,
            style: GoogleFonts.alata(
              fontSize: 34,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedText(
          text: "Flutter Developer",
          controller: controller.typewriterController,
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: controller.fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: controller.fadeAnimation.value,
              child: Transform.translate(
                offset: Offset(-30 * (1 - controller.fadeAnimation.value), 0),
                child: Text(
                  portfolioData.description,
                  style: GoogleFonts.alata(
                    fontSize: 17,
                    height: 1.8,
                    color: const Color(0xFFE2E8F0),
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 30),
        ActionButtons(controller: controller),
      ],
    );
  }
}
