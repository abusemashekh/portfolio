import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSmallScreen;
  final AnimationController animationController;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const CustomSectionHeader(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isSmallScreen,
      required this.animationController,
      required this.fadeAnimation,
      required this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                // Animated underline
                Positioned(
                  bottom: -8,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: animationController.status == AnimationStatus.dismissed ? 0.0 : 1.0),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Container(
                            height: 4,
                            width: 120 * value,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.purple],
                              ),
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3 * value),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 16 : 20,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
