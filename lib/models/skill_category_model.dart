class SkillCategoryModel {
  final String title;
  final List<String> tools;

  SkillCategoryModel({
    required this.title,
    required this.tools,
  });
}

final List<SkillCategoryModel> skillCategories = [
  SkillCategoryModel(
    title: 'Design',
    tools: ['Figma', 'Zeplin', 'Adobe XD'],
  ),
  SkillCategoryModel(
    title: 'Version Control',
    tools: ['Git', 'Bitbucket', 'GitHub'],
  ),
  SkillCategoryModel(
    title: 'IDE & Editors',
    tools: ['Android Studio', 'VS Code'],
  ),
  SkillCategoryModel(
    title: 'State Management',
    tools: ['GetX', 'Provider', 'Riverpod', 'Bloc'],
  ),
  SkillCategoryModel(
    title: 'Networking',
    tools: ['Dio', 'http'],
  ),
  SkillCategoryModel(
    title: 'Database & Storage',
    tools: ['Hive', 'SharedPreferences', 'SQLite', 'Firebase', 'Supabase'],
  ),
  SkillCategoryModel(
    title: 'Animations & UI',
    tools: ['Material Design', 'Cupertino Design', 'Lottie', 'Rive', 'SVG'],
  ),
  SkillCategoryModel(
    title: 'Monitoring & Analytics',
    tools: ['Firebase Crashlytics', 'Firebase Analytics'],
  ),
  SkillCategoryModel(
    title: 'Authentication & Security',
    tools: ['Firebase Auth', 'Supabase Auth', 'Social Login', 'Flutter Secure Storage'],
  ),
  SkillCategoryModel(
    title: 'Payment Gateways',
    tools: ['Razorpay', 'Stripe', 'PhonePe', 'Revenuecat'],
  ),
  SkillCategoryModel(
    title: 'Project Management',
    tools: ['Jira', 'Trello'],
  ),
  SkillCategoryModel(
    title: 'Other Tools',
    tools: ['Postman', 'Slack', 'Plaid', 'checkbook.io', 'array.com'],
  ),
];
