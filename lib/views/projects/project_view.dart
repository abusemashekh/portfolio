import 'package:flutter/material.dart';
import 'package:flutter_portfolio/components/custom_section_header.dart';
import 'package:flutter_portfolio/views/projects/custom_widgets/project_grid.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> with SingleTickerProviderStateMixin {
  late final AnimationController _titleAnimationController;
  late final Animation<double> _titleFadeAnimation;
  late final Animation<Offset> _titleSlideAnimation;
  final _headerVisibilityKey = UniqueKey();
  final _gridVisibilityKey = UniqueKey();
  bool _hasHeaderAnimated = false;
  bool _hasGridAnimated = false;

  @override
  void initState() {
    super.initState();
    _titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleAnimationController, curve: Curves.easeInOut),
    );

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _titleAnimationController, curve: Curves.easeOutCubic),
    );
  }

  void _onHeaderVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.01 && !_hasHeaderAnimated) {
      _hasHeaderAnimated = true;
      _titleAnimationController.forward();
    }
  }

  void _onGridVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.1 && !_hasGridAnimated) {
      _hasGridAnimated = true;
    }
  }

  @override
  void dispose() {
    _titleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 850;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VisibilityDetector(
          key: _headerVisibilityKey,
          onVisibilityChanged: _onHeaderVisibilityChanged,
          child: CustomSectionHeader(
            title: 'My Projects 💼',
            subtitle: 'Some cool things I’ve built',
            isSmallScreen: isSmallScreen,
            animationController: _titleAnimationController,
            fadeAnimation: _titleFadeAnimation,
            slideAnimation: _titleSlideAnimation,
          ),
        ),
        const SizedBox(height: 48),
        VisibilityDetector(
          key: _gridVisibilityKey,
          onVisibilityChanged: _onGridVisibilityChanged,
          child: const ProjectsGrid(),
        ),
      ],
    );
  }
}
