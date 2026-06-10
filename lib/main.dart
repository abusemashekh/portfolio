import 'package:flutter/material.dart';
import 'package:flutter_portfolio/utils/controller_injection.dart';
import 'package:flutter_portfolio/views/portfolio_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
  ControllerInjection.initControllers();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Abusema Shekh Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const PortfolioView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
