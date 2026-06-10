import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/controllers/portfolio_controller.dart';
import 'package:flutter_portfolio/generated/assets.dart';

class ProfileSection extends StatelessWidget {
  final PortfolioController controller;

  const ProfileSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: controller.fadeAnimation.value,
          child: Transform.scale(
            scale: 0.8 + (0.2 * controller.fadeAnimation.value),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _ProfileGlow(controller: controller),
                  _ProfileImage(controller: controller),
                  // _DecorativeShapes(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileGlow extends StatelessWidget {
  final PortfolioController controller;

  const _ProfileGlow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.rotationAnimation.value * 2 * math.pi,
          child: Container(
            width: 340,
            height: 340,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFF4ECDC4),
                  Color(0xFF667EEA),
                  Color(0xFF764BA2),
                  Color(0xFF4ECDC4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final PortfolioController controller;

  const _ProfileImage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, controller.floatingAnimation.value),
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF334155)],
              ),
              border: Border.all(
                color: const Color(0xFF4ECDC4),
                width: 4,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: Image.asset(
                Assets.images.avatarPixarJpg.path,
                fit: BoxFit.cover,
                height: 150,
                width: 150,
                colorBlendMode: BlendMode.exclusion,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DecorativeShapes extends StatefulWidget {
  @override
  _DecorativeShapesState createState() => _DecorativeShapesState();
}

class _DecorativeShapesState extends State<_DecorativeShapes> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initShapeAnimations();
  }

  void _initShapeAnimations() {
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: Duration(seconds: 4 + index),
        vsync: this,
      )..repeat(reverse: true);
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: -15.0, end: 15.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildShape(0, -30, -30, null, null, 60, const Color(0xFF4ECDC4), 20),
        _buildShape(1, null, -40, -20, null, 40, const Color(0xFF667EEA), 0),
        _buildShape(2, 0, null, null, -50, 30, const Color(0xFFF9CA24), 45),
      ],
    );
  }

  Widget _buildShape(int index, double? top, double? right, double? bottom, double? left, double size, Color color, double rotation) {
    return AnimatedBuilder(
      animation: _animations[index],
      builder: (context, child) {
        return Positioned(
          top: top != null ? top + _animations[index].value : null,
          right: right,
          bottom: bottom,
          left: left,
          child: Transform.rotate(
            angle: rotation * math.pi / 180,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color.withOpacity(0.6),
                borderRadius: index == 1 ? BorderRadius.circular(size / 2) : BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
