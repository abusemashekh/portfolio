import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final int particleCount = 50;

  @override
  void initState() {
    super.initState();
    _initializeParticles();
  }

  void _initializeParticles() {
    _controllers = [];
    _animations = [];

    for (int i = 0; i < particleCount; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: 5 + math.Random().nextInt(3)),
        vsync: this,
      )..repeat();

      final animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

      _controllers.add(controller);
      _animations.add(animation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F0F23),
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
          ],
        ),
      ),
      child: Stack(
        children: [
          /*...List.generate(particleCount, (index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Positioned(
                  left: math.Random().nextDouble() * MediaQuery.of(context).size.width,
                  top: MediaQuery.of(context).size.height * _animations[index].value,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ECDC4).withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            );
          }),*/
          _buildFloatingElements(),
        ],
      ),
    );
  }

  Widget _buildFloatingElements() {
    return Stack(
      children: [
        _FloatingElement(
          size: 80,
          color: const Color(0xFF4ECDC4).withOpacity(0.1),
          top: 0.2,
          left: 0.1,
          radius: 24,
          duration: 6,
        ),
        _FloatingElement(
          size: 120,
          color: const Color(0xFF667EEA).withOpacity(0.1),
          top: 0.7,
          right: 0.3,
          radius: 32,
          duration: 8,
        ),
        _FloatingElement(
          size: 60,
          color: const Color(0xFF45B7D1).withOpacity(0.1),
          bottom: 0.2,
          left: 0.2,
          radius: 50,
          duration: 5,
        ),
        _FloatingElement(
          size: 100,
          color: const Color(0xFFF9CA24).withOpacity(0.1),
          top: 0.1,
          right: 0.3,
          duration: 7,
        ),
      ],
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

class _FloatingElement extends StatefulWidget {
  final double size;
  final Color color;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double? radius;
  final int duration;

  const _FloatingElement({
    required this.size,
    required this.color,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.radius,
    required this.duration,
  });

  @override
  _FloatingElementState createState() => _FloatingElementState();
}

class _FloatingElementState extends State<_FloatingElement> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -20.0, end: 20.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: widget.top != null ? MediaQuery.of(context).size.height * widget.top! + _animation.value : null,
          bottom: widget.bottom != null ? MediaQuery.of(context).size.height * widget.bottom! - _animation.value : null,
          left: widget.left != null ? MediaQuery.of(context).size.width * widget.left! : null,
          right: widget.right != null ? MediaQuery.of(context).size.width * widget.right! : null,
          child: Transform(
            transform: Matrix4.rotationZ(_animation.value * math.pi / 180),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.radius ?? 16),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
