import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/skill_category_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolChips extends StatelessWidget {
  final SkillCategoryModel category;
  final double cardWidth;
  final bool isHovered;

  const ToolChips({super.key, required this.category, required this.cardWidth, required this.isHovered});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;

    return SingleChildScrollView(
      child: Wrap(
        spacing: isMobile ? 8 : 12,
        runSpacing: isMobile ? 8 : 12,
        children: category.tools.map((tool) => _buildToolChip(tool, screenWidth)).toList(),
      ),
    );
  }

  Widget _buildToolChip(String tool, double screenWidth) {
    final isMobile = screenWidth <= 600;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            constraints: BoxConstraints(maxWidth: cardWidth * 0.35, minHeight: isMobile ? 36 : 32),
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 16, vertical: isMobile ? 10 : 8),
            /*decoration: BoxDecoration(
              // Enhanced gradient for chips
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[800]!.withOpacity(0.3),
                  Colors.blue[900]!.withOpacity(0.2),
                  Colors.indigo[900]!.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.blue.withOpacity(0.5),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                // Inner glow effect
                BoxShadow(
                  color: Colors.white.withOpacity(0.05),
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),*/
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
            child: Center(
              child: Text(
                tool,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
