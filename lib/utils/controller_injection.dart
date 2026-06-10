import 'package:flutter_portfolio/controllers/portfolio_controller.dart';
import 'package:flutter_portfolio/views/contact/contact_controller.dart';
import 'package:get/get.dart';

class ControllerInjection {
  static initControllers() {
    Get.put(PortfolioController());
    Get.put(ContactController());
  }
}
