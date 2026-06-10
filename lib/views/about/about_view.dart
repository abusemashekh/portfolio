import 'package:flutter/material.dart';
import 'package:flutter_portfolio/controllers/portfolio_controller.dart';
import 'package:flutter_portfolio/views/about/custom_widgets/content_section.dart';
import 'package:flutter_portfolio/views/about/custom_widgets/profile_section.dart';

class AboutView extends StatelessWidget {
  final PortfolioController controller;
  final bool isMobile;

  const AboutView({super.key, required this.controller, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return isMobile ? _buildMobileLayout(controller) : _buildDesktopLayout(controller);
  }

  Widget _buildDesktopLayout(PortfolioController controller) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ContentSection(controller: controller),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: ProfileSection(controller: controller),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(PortfolioController controller) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ProfileSection(controller: controller),
        const SizedBox(height: 40),
        ContentSection(controller: controller),
      ],
    );
  }
}
