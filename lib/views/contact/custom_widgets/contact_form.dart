import 'package:flutter/material.dart';
import 'package:flutter_portfolio/views/contact/contact_controller.dart';
import 'package:flutter_portfolio/views/contact/custom_widgets/custom_textfield.dart';
import 'package:flutter_portfolio/views/contact/custom_widgets/submit_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactFormSection extends StatelessWidget {
  final ContactController controller;

  const ContactFormSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: controller.fadeAnimation,
          child: SlideTransition(
            position: controller.slideAnimation,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E1E1E),
                    Color(0xFF161616),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey[700]!.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Me a Message',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: controller.nameController,
                            label: 'Name',
                            hint: 'Your full name',
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            controller: controller.emailController,
                            label: 'Email',
                            hint: 'your.email@example.com',
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter your email';
                              }
                              if (!GetUtils.isEmail(value!)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: controller.subjectController,
                      label: 'Subject',
                      hint: 'What is this about?',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a subject';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: controller.messageController,
                      label: 'Message',
                      hint: 'Type your message here...',
                      maxLines: 5,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your message';
                        }
                        if (value!.length < 10) {
                          return 'Message should be at least 10 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    Obx(() => SubmitButton(
                          onPressed: controller.submitForm,
                          isLoading: controller.isLoading.value,
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
