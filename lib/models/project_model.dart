import 'package:flutter_portfolio/generated/assets.dart';

class ProjectModel {
  final String title;
  final String description;
  final List<AppLink>? appLinks;
  final List<String> tools;
  final List<String>? images;

  ProjectModel({
    required this.title,
    required this.description,
    this.appLinks,
    required this.tools,
    this.images,
  });
}

class AppLink {
  final String platform;
  final String link;

  AppLink({
    required this.platform,
    required this.link,
  });
}

final List<ProjectModel> projects = [
  ProjectModel(
    title: 'Adept Mobile – Document Management',
    description:
        'Adept Mobile extends Synergis Adept’s document system to both Android and iOS, offering document search, offline access, annotations, and seamless syncing. Built for remote and field users, I worked on the entire project as part of the core team, contributing to both functionality and UI.',
    tools: ['Flutter', 'Provider', 'REST API', 'Offline Support'],
    appLinks: [
      AppLink(platform: 'Android', link: 'https://play.google.com/store/apps/details?id=com.synergis.adept&pli=1'),
      AppLink(platform: 'iOS', link: 'https://apps.apple.com/in/app/synergis-adept-mobile/id6456038329'),
    ],
    images: [Assets.adept1, Assets.adept2, Assets.adept3],
  ),
  ProjectModel(
    title: 'RentRX – Rental Management App',
    description:
        'A smart rental management platform that simplifies rent tracking, auto-payments, credit checks, and reward systems. I contributed across the entire app development cycle, including UI design, API integration, and testing.',
    tools: ['Flutter', 'GetX', 'REST API', 'Checkbook.io', 'Array.com', 'Plaid', 'RevenueCat'],
    appLinks: [
      AppLink(platform: 'Android', link: 'https://play.google.com/store/apps/details?id=com.rentrx.app.rent_rx'),
    ],
    images: [Assets.rentRx1, Assets.rentRx2, Assets.rentRx3],
  ),
  ProjectModel(
    title: 'Shoot Your Shot® – Dating App',
    description:
        'A modern dating app offering real-time messaging, intelligent matching, and an engaging user experience. I developed the entire application end-to-end, ensuring smooth interaction, security, and performance.',
    tools: ['Flutter', 'Provider', 'Firebase', 'WebSockets', 'REST API'],
    appLinks: [
      AppLink(platform: 'Android', link: 'https://play.google.com/store/apps/details?id=com.shootyourshot'),
      AppLink(platform: 'iOS', link: 'https://apps.apple.com/us/app/shoot-your-shot-dating-app/id1497413070'),
    ],
    images: [Assets.shootYourShot1, Assets.shootYourShot2, Assets.shootYourShot3],
  ),
  ProjectModel(
    title: 'Bunifu Parent App – School Bus Tracking',
    description:
        'This app helps parents monitor school bus routes in real-time, receive custom alerts, and manage pickup schedules. I developed the full application from scratch, delivering features for tracking, notifications, and user communication.',
    tools: ['Flutter', 'Firebase', 'Bloc', 'Google Maps', 'REST API', 'WebSockets'],
    appLinks: [
      AppLink(platform: 'Android', link: 'https://play.google.com/store/apps/details?id=io.bunifu.go.parent.jga2'),
      AppLink(platform: 'iOS', link: 'https://apps.apple.com/eg/app/jonathan-gloag-parent/id1624217623'),
    ],
    images: [Assets.bunifu1, Assets.bunifu2, Assets.bunifu3],
  ),
  ProjectModel(
    title: 'GreenWellBiotech – Agriculture Product Catalog & Ordering App',
    description:
        'An agriculture product app for farmers and retailers to explore, learn about, and purchase high-quality crop solutions. I contributed to the entire app development including product listing, category management, and user-friendly ordering flow.',
    tools: ['Flutter', 'GetX', 'REST API', 'Firebase'],
    images: [Assets.greenWell1, Assets.greenWell2, Assets.greenWell3],
    appLinks: [
      AppLink(platform: 'Android', link: 'https://play.google.com/store/apps/details?id=com.green_well.biotech'),
    ],
  ),
  ProjectModel(
    title: 'Aarchiev Gold Jewellery Store',
    description:
        'A jewellery shopping app offering a wide range of gold, diamond, and gemstone designs for men, women, and kids. I handled end-to-end development including product browsing, offer integration, and smooth shopping experience.',
    tools: ['Flutter', 'Provider', 'REST API', 'Firebase'],
    appLinks: [
      AppLink(platform: 'Android', link: 'https://play.google.com/store/apps/details?id=com.aarchiev.aarchievgold'),
      AppLink(platform: 'iOS', link: 'https://apps.apple.com/in/app/aarchiev-gold-jewellery-store/id1664321022'),
    ],
    images: [Assets.aarchiev1, Assets.aarchiev2, Assets.aarchiev3],
  ),
  ProjectModel(
    title: 'TADDA – Food Delivery Platform',
    description:
        'A comprehensive food delivery app supporting users, restaurants, and delivery partners with real-time order tracking and individual dashboards. I was involved in building all three modules and collaborated closely on design and feature implementation.',
    tools: ['Flutter', 'Firebase', 'Provider', 'REST API'],
    images: [Assets.tadda1],
  ),
  ProjectModel(
    title: 'Holy11 – Fantasy Sports Betting',
    description:
        'A fantasy sports app where users create teams, join contests, and earn based on match performance. I contributed to the full development process including team management, match integration, and leaderboard logic.',
    tools: ['Flutter', 'Provider', 'REST API', 'Firebase'],
    images: [Assets.holy111],
  ),
];
