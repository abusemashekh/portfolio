class PortfolioModel {
  final String greeting;
  final String name;
  final String description;
  final String primaryButtonText;
  final String secondaryButtonText;

  PortfolioModel({
    required this.greeting,
    required this.name,
    required this.description,
    required this.primaryButtonText,
    required this.secondaryButtonText,
  });
}

final PortfolioModel portfolioData = PortfolioModel(
  greeting: "Hi, I'm",
  name: "Abusema Shekh",
  description:
      "With 4 years of experience in Flutter development, I specialize in creating stunning, high-performance mobile applications. I'm passionate about clean code, pixel-perfect designs, and delivering exceptional user experiences. My expertise spans across Flutter, Dart, Firebase, and modern app development practices.",
  primaryButtonText: "Let's Work Together",
  secondaryButtonText: "Download CV",
);
