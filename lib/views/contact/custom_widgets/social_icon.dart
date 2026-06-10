import 'package:flutter/material.dart';
import 'package:flutter_portfolio/views/contact/contact_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLinksSection extends StatelessWidget {
  final ContactController controller;

  const SocialLinksSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Me',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            SocialLinkButton(
              icon: Icons.link,
              label: 'LinkedIn',
              onTap: controller.launchLinkedIn,
            ),
            const SizedBox(width: 16),
            SocialLinkButton(
              icon: Icons.code,
              label: 'GitHub',
              onTap: controller.launchGitHub,
            ),
          ],
        ),
      ],
    );
  }
}

class SocialLinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SocialLinkButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<SocialLinkButton> createState() => _SocialLinkButtonState();
}

class _SocialLinkButtonState extends State<SocialLinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered ? [Colors.blue.withOpacity(0.2), Colors.blue.withOpacity(0.1)] : [Colors.grey[800]!.withOpacity(0.3), Colors.grey[900]!.withOpacity(0.2)],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: _isHovered ? Colors.blue.withOpacity(0.4) : Colors.grey[700]!.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isHovered ? Colors.blue : Colors.grey[300],
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: _isHovered ? Colors.blue : Colors.grey[300],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
