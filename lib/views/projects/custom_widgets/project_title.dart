import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTitleSection extends StatelessWidget {
  final String title;
  final bool isHovered;
  final bool isMobile;

  const ProjectTitleSection({
    super.key,
    required this.title,
    required this.isHovered,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 20.0),
      child: Row(
        children: [
          ProjectTitleAccent(isMobile: isMobile),
          const SizedBox(width: 12),
          Flexible(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: isHovered ? [Colors.white, Colors.blue.shade200] : [Colors.white, Colors.grey.shade300],
              ).createShader(bounds),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Title accent bar
class ProjectTitleAccent extends StatelessWidget {
  final bool isMobile;

  const ProjectTitleAccent({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? 6 : 8,
      height: isMobile ? 20 : 24,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.blue.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
