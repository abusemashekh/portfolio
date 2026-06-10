import 'package:flutter/material.dart';
import 'package:flutter_portfolio/components/custom_section_header.dart';
import 'package:flutter_portfolio/views/skills/custom_widgets/skills_grid.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsView extends StatefulWidget {
  const SkillsView({super.key});

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  final _headerVisibilityKey = UniqueKey();
  final _gridVisibilityKey = UniqueKey();
  bool _hasHeaderAnimated = false;
  bool _hasGridAnimated = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  void _onHeaderVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.01 && !_hasHeaderAnimated) {
      _hasHeaderAnimated = true;
      _animationController.forward();
    }
  }

  void _onGridVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.1 && !_hasGridAnimated) {
      _hasGridAnimated = true;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
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
            title: 'My Toolbox 🛠️',
            subtitle: 'Technologies I work with',
            isSmallScreen: isSmallScreen,
            animationController: _animationController,
            fadeAnimation: _fadeAnimation,
            slideAnimation: _slideAnimation,
          ),
        ),
        const SizedBox(height: 48),
        VisibilityDetector(
          key: _gridVisibilityKey,
          onVisibilityChanged: _onGridVisibilityChanged,
          child: SkillsGrid(animationController: _animationController),
        ),
      ],
    );
  }
}
