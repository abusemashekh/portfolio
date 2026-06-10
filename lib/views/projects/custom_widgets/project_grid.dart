import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/project_model.dart';
import 'package:flutter_portfolio/views/projects/custom_widgets/project_card.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsGrid extends StatefulWidget {
  const ProjectsGrid({super.key});

  @override
  State<ProjectsGrid> createState() => _ProjectsGridState();
}

class _ProjectsGridState extends State<ProjectsGrid> with TickerProviderStateMixin {
  bool showAll = false;
  late AnimationController _buttonController;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _buttonGlowAnimation;
  bool _isButtonHovered = false;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOutCubic),
    );

    _buttonGlowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void _handleButtonHover(bool isHovered) {
    setState(() => _isButtonHovered = isHovered);
    if (isHovered) {
      _buttonController.forward();
    } else {
      _buttonController.reverse();
    }
  }

  void _toggleShowAll() {
    setState(() => showAll = !showAll);
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1400) return 3;
    if (screenWidth > 800) return 2;
    return 1;
  }

  double _getSpacing(double screenWidth) {
    if (screenWidth > 1400) return 24;
    if (screenWidth > 800) return 20;
    return 16;
  }

  double _getCardHeight(double screenHeight) {
    if (screenHeight > 1400) return screenHeight / 1.2;
    if (screenHeight > 800) return screenHeight / 1.5;
    return screenHeight / 1.5;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final spacing = _getSpacing(screenWidth);
    final crossAxisCount = _getCrossAxisCount(screenWidth);
    final isMobile = screenWidth <= 600;

    final visibleProjects = showAll ? projects : projects.take(6).toList();

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleProjects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            mainAxisExtent: _getCardHeight(screenHeight),
          ),
          itemBuilder: (context, index) {
            if (index >= 6) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 400 + ((index - 6) * 150)),
                curve: Curves.easeOutCubic,
                transform: showAll ? Matrix4.identity() : Matrix4.translationValues(0, 50, 0),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 400 + ((index - 6) * 150)),
                  opacity: showAll ? 1.0 : 0.0,
                  curve: Curves.easeOutCubic,
                  child: AnimatedScale(
                    duration: Duration(milliseconds: 400 + ((index - 6) * 150)),
                    scale: showAll ? 1.0 : 0.8,
                    curve: Curves.easeOutCubic,
                    child: ProjectCard(project: visibleProjects[index]),
                  ),
                ),
              );
            }
            return ProjectCard(project: visibleProjects[index]);
          },
        ),
        SizedBox(height: spacing),
        if (projects.length > 6)
          Center(
            child: MouseRegion(
              onEnter: (_) => _handleButtonHover(true),
              onExit: (_) => _handleButtonHover(false),
              child: AnimatedBuilder(
                animation: _buttonController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _buttonScaleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _isButtonHovered
                              ? [
                                  Colors.blue.withOpacity(0.8),
                                  Colors.blue.shade600,
                                  Colors.blue.shade800,
                                ]
                              : [
                                  const Color(0xFF2D2D2D),
                                  const Color(0xFF1F1F1F),
                                  const Color(0xFF0A0A0A),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: _isButtonHovered ? Colors.blue.withOpacity(0.6) : Colors.grey[700]!.withOpacity(0.4),
                          width: _isButtonHovered ? 2.0 : 1.0,
                        ),
                        boxShadow: [
                          // Main shadow
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: _isButtonHovered ? 20 : 10,
                            offset: Offset(0, _isButtonHovered ? 8 : 4),
                          ),
                          // Glow effect
                          if (_isButtonHovered)
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3 * _buttonGlowAnimation.value),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          // Inner highlight
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _toggleShowAll,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 24 : 32,
                              vertical: isMobile ? 12 : 16,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Icon with rotation animation
                                AnimatedRotation(
                                  turns: showAll ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: _isButtonHovered ? Colors.white.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      showAll ? Icons.expand_less : Icons.expand_more,
                                      color: _isButtonHovered ? Colors.white : Colors.blue.shade300,
                                      size: isMobile ? 20 : 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Animated text
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0.5),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    showAll ? "Show Less" : "Show More",
                                    key: ValueKey(showAll),
                                    style: GoogleFonts.poppins(
                                      color: _isButtonHovered ? Colors.white : Colors.grey[300],
                                      fontSize: isMobile ? 14 : 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Count indicator
                                if (!showAll)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.withOpacity(0.3),
                                          Colors.blue.withOpacity(0.1),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.blue.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "+${projects.length - 6}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.blue.shade300,
                                        fontSize: isMobile ? 11 : 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        const SizedBox(height: 40),
      ],
    );
  }
}
