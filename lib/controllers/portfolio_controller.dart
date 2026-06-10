import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/generated/assets.dart';
import 'package:flutter_portfolio/utils/file_downloader.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class PortfolioController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController fadeController;
  late AnimationController typewriterController;
  late AnimationController floatingController;
  late AnimationController rotationController;

  late Animation<double> fadeAnimation;
  late Animation<double> typewriterAnimation;
  late Animation<double> floatingAnimation;
  late Animation<double> rotationAnimation;

  late ScrollController scrollController;
  final Map<String, GlobalKey> _sectionKeys = {
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  GlobalKey get aboutKey => _sectionKeys['about']!;

  GlobalKey get skillsKey => _sectionKeys['skills']!;

  GlobalKey get projectsKey => _sectionKeys['projects']!;

  GlobalKey get contactKey => _sectionKeys['contact']!;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    scrollController = AutoScrollController();
  }

  void _initializeAnimations() {
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeOut),
    );
    typewriterController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    typewriterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: typewriterController, curve: Curves.easeInOut),
    );
    floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: floatingController, curve: Curves.easeInOut),
    );

    rotationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
    rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      rotationController,
    );

    _startAnimations();
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 500), () {
      fadeController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      typewriterController.forward();
    });
  }

  void _scrollToSection(GlobalKey key, {double offset = 120}) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final targetPosition = scrollController.offset + position.dy - offset;

      scrollController.animateTo(
        targetPosition.clamp(0.0, scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToAbout() {
    _scrollToSection(aboutKey, offset: 260);
  }

  void scrollToSkills() {
    _scrollToSection(skillsKey);
  }

  void scrollToProjects() {
    _scrollToSection(projectsKey);
  }

  void scrollToContact() {
    _scrollToSection(contactKey);
  }

  void scrollToSection(String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'about':
        scrollToAbout();
        break;
      case 'skills':
        scrollToSkills();
        break;
      case 'projects':
        scrollToProjects();
        break;
      case 'contact':
        scrollToContact();
        break;
      default:
        scrollToAbout();
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  //https://drive.google.com/file/d/1QbvdRY0xOrtLvgmATpm6t--3CDrH-KAI/view?usp=sharing

  Future<void> onDownloadButtonPressed() async {
    try {
      const String cvUrl =
          'https://drive.google.com/uc?export=download&id=1QbvdRY0xOrtLvgmATpm6t--3CDrH-KAI';

      await FileDownloader.downloadFile(
        url: cvUrl,
        fileName: 'abusema_shekh.pdf',
        savePath: 'CVs',
        successMessage: 'CV downloaded successfully!',
        errorMessage: 'Failed to download CV. Please try again.',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading CV: $e');
      }
    }
  }

  @override
  void onClose() {
    fadeController.dispose();
    typewriterController.dispose();
    floatingController.dispose();
    rotationController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
