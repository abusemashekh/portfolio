import 'package:flutter/material.dart';
import 'package:flutter_portfolio/components/custom_section_header.dart';
import 'package:flutter_portfolio/views/contact/contact_controller.dart';
import 'package:flutter_portfolio/views/contact/custom_widgets/contact_form.dart';
import 'package:flutter_portfolio/views/contact/custom_widgets/contact_info.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 850;

    return VisibilityDetector(
      key: controller.headerVisibilityKey,
      onVisibilityChanged: controller.onHeaderVisibilityChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            title: 'Get In Touch 📫',
            subtitle: 'Let\'s work together on your next project',
            isSmallScreen: isSmallScreen,
            animationController: controller.animationController,
            fadeAnimation: controller.fadeAnimation,
            slideAnimation: controller.slideAnimation,
          ),
          const SizedBox(height: 48),
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactInfoSection(controller: controller),
                    const SizedBox(height: 40),
                    ContactFormSection(controller: controller),
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ContactInfoSection(controller: controller),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 2,
                        child: ContactFormSection(controller: controller),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
