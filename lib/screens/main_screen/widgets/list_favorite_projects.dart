import 'package:ddd/model_provider/model_main.dart';
import 'package:ddd/screens/main_screen/widgets/card_favorite_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFavoriteProjects extends StatelessWidget {
  const ListFavoriteProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Избранные проекты:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton(
                value: model.sortFavoriteValue,
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
                onChanged: (String? value) => model.sortFavoriteProjects(value),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Expanded(child: CardFavoriteProject()),
        ],
      ),
    );
  }
}
