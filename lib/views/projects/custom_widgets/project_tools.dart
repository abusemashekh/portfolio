import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectToolsSection extends StatelessWidget {
  final List<String> tools;
  final bool isHovered;
  final bool isMobile;

  const ProjectToolsSection({
    super.key,
    required this.tools,
    required this.isHovered,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 20.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tools.map((tool) {
          return ProjectToolChip(
            tool: tool,
            isHovered: isHovered,
            isMobile: isMobile,
          );
        }).toList(),
      ),
    );
  }
}

// Individual tool chip
class ProjectToolChip extends StatelessWidget {
  final String tool;
  final bool isHovered;
  final bool isMobile;

  const ProjectToolChip({
    super.key,
    required this.tool,
    required this.isHovered,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHovered
              ? [
                  Colors.blue.withOpacity(0.2),
                  Colors.blue.withOpacity(0.1),
                ]
              : [
                  Colors.grey[800]!.withOpacity(0.6),
                  Colors.grey[900]!.withOpacity(0.4),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHovered ? Colors.blue.withOpacity(0.4) : Colors.grey[700]!.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          if (isHovered)
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
        ],
      ),
      child: Text(
        tool,
        style: GoogleFonts.poppins(
          color: isHovered ? Colors.blue.shade200 : Colors.grey[300],
          fontSize: isMobile ? 11 : 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
