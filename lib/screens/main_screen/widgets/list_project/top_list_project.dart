import 'package:ddd/screens/main_screen/model/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dropdown_button_widget.dart';

class TopListProject extends StatelessWidget {
  const TopListProject({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Text(
                'Все проекты:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => model.addProject(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        DropdownButtonWidget(projects: model.projects),
      ],
    );
  }
}
