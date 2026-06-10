import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/skill_category_model.dart';
import 'package:flutter_portfolio/views/skills/custom_widgets/tool_chips.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillCard extends StatefulWidget {
  final SkillCategoryModel category;
  final int index;
  final AnimationController animationController;
  final double cardWidth;

  const SkillCard({
    super.key,
    required this.category,
    required this.index,
    required this.animationController,
    required this.cardWidth,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _shadowAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _shadowAnimation = Tween<double>(begin: 1.0, end: 2.5).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    if (mounted) {
      setState(() => _isHovered = isHovered);
      if (isHovered) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;

    return MouseRegion(
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: _isHovered ? Matrix4.translationValues(0, -10, 0) : Matrix4.identity(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              // Enhanced gradient background
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isHovered
                    ? [
                        const Color(0xFF2D2D2D),
                        const Color(0xFF1F1F1F),
                        const Color(0xFF0A0A0A),
                      ]
                    : [
                        const Color(0xFF1E1E1E),
                        const Color(0xFF161616),
                        const Color(0xFF0F0F0F),
                      ],
                stops: const [0.0, 0.6, 1.0],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered ? Colors.blue.withOpacity(0.8) : Colors.grey[700]!.withOpacity(0.4),
                width: _isHovered ? 2.0 : 1.0,
              ),
              boxShadow: [
                // Main shadow
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 15 * _shadowAnimation.value,
                  offset: Offset(0, 8 * _shadowAnimation.value),
                ),
                // Glow effect on hover
                if (_isHovered)
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2 * _glowAnimation.value),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                // Inner highlight
                BoxShadow(
                  color: Colors.white.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Decorative corner accent
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(_isHovered ? 0.3 : 0.1),
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                // Main content
                Padding(
                  padding: EdgeInsets.all(isMobile ? 16.0 : 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enhanced title with decoration
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.blue.withOpacity(_isHovered ? 0.6 : 0.3),
                              width: _isHovered ? 2.0 : 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Title icon/decoration
                            Container(
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
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: _isHovered ? [Colors.white, Colors.blue.shade200] : [Colors.white, Colors.grey.shade300],
                                ).createShader(bounds),
                                child: Text(
                                  widget.category.title,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: isMobile ? 16 : 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 20),
                      Expanded(
                        child: ToolChips(category: widget.category, cardWidth: widget.cardWidth, isHovered: _isHovered),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
