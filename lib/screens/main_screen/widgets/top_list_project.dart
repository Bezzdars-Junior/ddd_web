import 'package:ddd/model_provider/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => model.addProject(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        DropdownButton(
          value: model.sortValue,
          items:
              [
                'Имя(по возр.)',
                'Имя(по убыв.)',
                'Дата(по возр.)',
                'Дата(по убыв.)',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? value) => model.sortProjects(value),
        ),
      ],
    );
  }
}
