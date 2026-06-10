import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/project_model.dart';
import 'package:flutter_portfolio/views/projects/custom_widgets/project_app_links.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDescriptionSection extends StatelessWidget {
  final String description;
  final bool isMobile;
  final double screenWidth;

  const ProjectDescriptionSection({
    super.key,
    required this.description,
    required this.isMobile,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 20.0),
      child: Text(
        description,
        style: GoogleFonts.poppins(
          color: Colors.grey[300],
          fontSize: isMobile ? 13 : 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        maxLines: screenWidth >= 800 && screenWidth < 1200 ? 6 : 7,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// Project app links section
class ProjectAppLinksSection extends StatelessWidget {
  final List<AppLink> appLinks;
  final bool isMobile;
  final bool isHovered;

  const ProjectAppLinksSection({
    super.key,
    required this.appLinks,
    required this.isMobile,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Available On:',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[200],
            ),
          ),
          Row(
            children: appLinks.map((link) {
              return AppLinkIcon(
                appLink: link,
                isMobile: isMobile,
                isHovered: isHovered,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
