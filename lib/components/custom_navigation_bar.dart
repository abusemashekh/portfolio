import 'package:flutter/material.dart';
import 'package:flutter_portfolio/controllers/portfolio_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavigationBar extends GetView<PortfolioController> {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 768;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.0 : Get.width * 0.08, vertical: 16),
          child: isMobile ? _buildMobileNavigation(controller) : _buildDesktopNavigation(controller),
        );
      },
    );
  }

  Widget _buildDesktopNavigation(PortfolioController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kToolbarHeight / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildNavItem('About', controller.scrollToAbout),
          SizedBox(width: Get.width * 0.028),
          _buildNavItem('Skills', controller.scrollToSkills),
          SizedBox(width: Get.width * 0.028),
          _buildNavItem('Projects', controller.scrollToProjects),
          SizedBox(width: Get.width * 0.028),
          _buildNavItem('Contact', controller.scrollToContact),
        ],
      ),
    );
  }

  Widget _buildMobileNavigation(PortfolioController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: controller.scrollToTop,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ).createShader(bounds),
              child: Text(
                'Portfolio',
                /*style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),*/
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: PopupMenuButton<VoidCallback>(
            icon: Icon(Icons.menu_rounded, color: Colors.white, size: 28),
            color: Colors.grey[900]?.withOpacity(0.95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            elevation: 20,
            onSelected: (callback) => callback(),
            itemBuilder: (context) => [
              _buildPopupMenuItem('About', controller.scrollToAbout, Icons.person_outline),
              _buildPopupMenuItem('Skills', controller.scrollToSkills, Icons.code_outlined),
              _buildPopupMenuItem('Projects', controller.scrollToProjects, Icons.work_outline),
              _buildPopupMenuItem('Contact', controller.scrollToContact, Icons.contact_mail_outlined),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<VoidCallback> _buildPopupMenuItem(
    String title,
    VoidCallback onTap,
    IconData icon,
  ) {
    return PopupMenuItem<VoidCallback>(
      value: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
