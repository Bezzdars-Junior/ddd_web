import 'package:ddd/screens/project_screen/model/model_project.dart';
import 'package:ddd/screens/project_screen/view_projet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Страница проекта с встраиванием [Provider].
class ProjectScreen extends StatefulWidget {
  /// Конструктор [ProjectScreen].
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelProject(),
      child: const ViewProjectScreen(),
    );
  }
}
