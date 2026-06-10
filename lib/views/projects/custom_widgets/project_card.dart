import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/project_model.dart';
import 'package:flutter_portfolio/views/projects/custom_widgets/project_description.dart';
import 'package:flutter_portfolio/views/projects/custom_widgets/project_image.dart';
import 'package:flutter_portfolio/views/projects/custom_widgets/project_title.dart';
import 'package:flutter_portfolio/views/projects/custom_widgets/project_tools.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
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
        child: ProjectCardContainer(
          isHovered: _isHovered,
          shadowAnimation: _shadowAnimation,
          glowAnimation: _glowAnimation,
          child: Stack(
            children: [
              ProjectCardCornerAccent(isHovered: _isHovered),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProjectImageSection(
                    project: widget.project,
                    isMobile: isMobile,
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  ProjectTitleSection(
                    title: widget.project.title,
                    isHovered: _isHovered,
                    isMobile: isMobile,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  ProjectDescriptionSection(
                    description: widget.project.description,
                    isMobile: isMobile,
                    screenWidth: screenWidth,
                  ),
                  const Spacer(),
                  if (widget.project.appLinks != null && widget.project.appLinks!.isNotEmpty)
                    ProjectAppLinksSection(
                      appLinks: widget.project.appLinks!,
                      isMobile: isMobile,
                      isHovered: _isHovered,
                    ),
                  const Spacer(),
                  ProjectToolsSection(
                    tools: widget.project.tools,
                    isHovered: _isHovered,
                    isMobile: isMobile,
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCardContainer extends StatelessWidget {
  final bool isHovered;
  final Animation<double> shadowAnimation;
  final Animation<double> glowAnimation;
  final Widget child;

  const ProjectCardContainer({
    super.key,
    required this.isHovered,
    required this.shadowAnimation,
    required this.glowAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isHovered
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15 * shadowAnimation.value,
            offset: Offset(0, 8 * shadowAnimation.value),
          ),
          if (isHovered)
            BoxShadow(
              color: Colors.blue.withOpacity(0.2 * glowAnimation.value),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ProjectCardCornerAccent extends StatelessWidget {
  final bool isHovered;

  const ProjectCardCornerAccent({
    super.key,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(isHovered ? 0.3 : 0.1),
              Colors.transparent,
            ],
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}
