import 'package:flutter/material.dart';
import 'package:flutter_portfolio/controllers/portfolio_controller.dart';
import 'package:flutter_portfolio/models/portfolio_model.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ActionButtons extends StatelessWidget {
  final PortfolioController controller;

  const ActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: controller.fadeAnimation.value,
          child: Transform.scale(
            scale: 0.3 + (0.7 * controller.fadeAnimation.value),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 400;

                return isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _PrimaryButton(
                            text: portfolioData.primaryButtonText,
                            onPressed: () {
                              controller.scrollToSection('contact');
                            },
                          ),
                          const SizedBox(height: 15),
                          _PrimaryButton(
                            text: portfolioData.secondaryButtonText,
                            onPressed: controller.onDownloadButtonPressed,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          _PrimaryButton(
                            text: portfolioData.primaryButtonText,
                            onPressed: () {
                              controller.scrollToSection('contact');
                            },
                          ),
                          const SizedBox(width: 20),
                          _PrimaryButton(
                            text: portfolioData.secondaryButtonText,
                            onPressed: controller.onDownloadButtonPressed,
                          ),
                        ],
                      );
              },
            ),
          ),
        );
      },
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 200),
        tween: ColorTween(
          begin: Colors.transparent,
          end: Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        builder: (context, color, child) {
          return Container(
            decoration: BoxDecoration(
              border: const GradientBoxBorder(
                gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: OutlinedButton(
                onHover: (isHovered) {},
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  animationDuration: const Duration(milliseconds: 200),
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
