import 'package:flutter/material.dart';
import 'package:flutter_portfolio/views/contact/contact_controller.dart';

import 'contact_info_card.dart';

class ContactInfoSection extends StatelessWidget {
  final ContactController controller;

  const ContactInfoSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: controller.fadeAnimation,
          child: SlideTransition(
            position: controller.slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContactInfoCard(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle: 'shekh17dev@gmail.com',
                  onTap: controller.launchEmail,
                ),
                const SizedBox(height: 20),
                ContactInfoCard(
                  icon: Icons.phone_outlined,
                  title: 'Phone',
                  subtitle: '+91 75729 35624',
                  onTap: controller.launchPhone,
                ),
                const SizedBox(height: 20),
                const ContactInfoCard(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  subtitle: 'Gujarat, India',
                  onTap: null,
                ),
                // const SizedBox(height: 32),
                // SocialLinksSection(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}
