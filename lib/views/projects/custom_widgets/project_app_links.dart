import 'package:flutter/material.dart';
import 'package:flutter_portfolio/generated/assets.dart';
import 'package:flutter_portfolio/models/project_model.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLinkIcon extends StatelessWidget {
  final AppLink appLink;
  final bool isMobile;
  final bool isHovered;

  const AppLinkIcon({
    super.key,
    required this.appLink,
    required this.isMobile,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _launchURL(appLink.link);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: isHovered ? const LinearGradient(colors: [Colors.blue, Colors.purple]) : LinearGradient(colors: [Colors.white.withOpacity(.1), Colors.white.withOpacity(.2)]),
            width: 2,
          ),
          shape: BoxShape.circle,
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            _getPlatformIcon(appLink.platform),
            width: isMobile ? 18 : 14,
            height: isMobile ? 18 : 14,
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'android':
        return Assets.iconsPlaystore;
      case 'ios':
      case 'iphone':
      case 'apple':
        return Assets.iconsAppStore;
      default:
        return Assets.iconsPlaystore;
    }
  }
}
