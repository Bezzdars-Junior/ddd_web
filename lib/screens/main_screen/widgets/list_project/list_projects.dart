import 'package:ddd/screens/main_screen/widgets/list_project/top_list_project.dart';
import 'package:ddd/screens/main_screen/widgets/table_card_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/model_main.dart';

class ListProjects extends StatelessWidget {
  const ListProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const TopListProject(),
          const SizedBox(height: 10),
          Expanded(
            child: TableCardProject(
              projects: model.projects,
            ),
          ),
        ],
      ),
    );
  }
}
