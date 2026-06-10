import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/skill_category_model.dart';
import 'package:flutter_portfolio/views/skills/custom_widgets/skill_card.dart';

class SkillsGrid extends StatelessWidget {
  final AnimationController animationController;

  SkillsGrid({super.key, required this.animationController});

  double _cardWidth = 0.0;

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1400) {
      _cardWidth = screenWidth / 4;
      return 4;
    } else if (screenWidth > 1000) {
      _cardWidth = screenWidth / 3;
      return 3;
    } else if (screenWidth > 600) {
      _cardWidth = screenWidth / 2;
      return 2;
    } else {
      _cardWidth = screenWidth;
      return 1;
    }
  }

  double _getCardHeight(double screenWidth) {
    if (screenWidth > 1400) {
      return 250;
    } else if (screenWidth > 1000) {
      return 260;
    } else if (screenWidth > 600) {
      return 250;
    } else {
      return 224;
    }
  }

  double _getSpacing(double screenWidth) {
    if (screenWidth > 1400) {
      return 24;
    } else if (screenWidth > 600) {
      return 20;
    } else {
      return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = _getCrossAxisCount(screenWidth);
    final cardHeight = _getCardHeight(screenWidth);
    final spacing = _getSpacing(screenWidth);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: constraints.maxWidth / (crossAxisCount * cardHeight),
          ),
          itemCount: skillCategories.length,
          itemBuilder: (context, index) {
            final category = skillCategories[index];
            return SkillCard(
              category: category,
              index: index,
              animationController: animationController,
              cardWidth: _cardWidth,
            );
          },
        );
      },
    );
  }
}
