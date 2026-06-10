import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/utils/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  final headerVisibilityKey = UniqueKey();
  bool hasHeaderAnimated = false;
  bool contentAnimated = false;

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  // Form validation
  final formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));
  }

  void onHeaderVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.01 && !hasHeaderAnimated) {
      hasHeaderAnimated = true;
      animationController.forward();
    }
  }

  Future<void> launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'shekh17dev@gmail.com',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+917572935624');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> launchLinkedIn() async {
    final Uri linkedinUri = Uri.parse('https://linkedin.com/in/yourprofile');

    if (await canLaunchUrl(linkedinUri)) {
      await launchUrl(linkedinUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> launchGitHub() async {
    final Uri githubUri = Uri.parse('https://github.com/yourusername');

    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    }
  }

  // Form submission
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final response = await sendMessageViaFormspree();
      if (response.statusCode == 200) {
        CustomSnackBar.show(
          title: 'Success!',
          message: 'Your message has been sent successfully.',
          isError: false,
        );

        nameController.clear();
        emailController.clear();
        subjectController.clear();
        messageController.clear();
      } else {
        CustomSnackBar.show(
          title: 'Error',
          message: 'Failed to send message. Please try again.',
          isError: true,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        title: 'Error',
        message: 'Failed to send message. Please try again.',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<http.Response> sendMessageViaFormspree() async {
    final url = Uri.parse('https://formspree.io/f/xjkrjgjk');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'subject': subjectController.text.trim(),
        'message': messageController.text.trim(),
      }),
    );
    return response;
  }

  @override
  void onClose() {
    animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
