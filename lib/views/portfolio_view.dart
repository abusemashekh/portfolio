import 'package:flutter/material.dart';
import 'package:flutter_portfolio/components/animated_background.dart';
import 'package:flutter_portfolio/components/custom_navigation_bar.dart';
import 'package:flutter_portfolio/controllers/portfolio_controller.dart';
import 'package:flutter_portfolio/views/about/about_view.dart';
import 'package:flutter_portfolio/views/contact/contact_view.dart';
import 'package:flutter_portfolio/views/projects/project_view.dart';
import 'package:flutter_portfolio/views/skills/skills_view.dart';
import 'package:get/get.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 768;

                return Column(
                  children: [
                    const CustomNavigationBar(),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12, vertical: isMobile ? 20 : 40),
                        child: Column(
                          children: [
                            SizedBox(height: isMobile ? size.height * 0.05 : size.height * 0.13),
                            Container(key: controller.aboutKey, child: AboutView(controller: controller, isMobile: isMobile)),
                            SizedBox(height: isMobile ? size.height * 0.1 : size.height * 0.2),
                            Container(key: controller.skillsKey, child: const SkillsView()),
                            SizedBox(height: isMobile ? size.height * 0.1 : size.height * 0.2),
                            Container(key: controller.projectsKey, child: const ProjectView()),
                            SizedBox(height: isMobile ? size.height * 0.1 : size.height * 0.2),
                            Container(key: controller.contactKey, child: const ContactView()),
                            SizedBox(height: isMobile ? size.height * 0.1 : size.height * 0.13),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
