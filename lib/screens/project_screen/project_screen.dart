import 'package:ddd/model_provider/model.dart';
import 'package:ddd/screens/project_screen/view_projet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: const ViewProjectScreen(),
    );
  }
}
