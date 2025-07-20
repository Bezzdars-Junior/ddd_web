import 'package:ddd/screens/main_screen/widgets/card_project.dart';
import 'package:ddd/screens/main_screen/widgets/top_list_project.dart';
import 'package:flutter/material.dart';

class ListProjects extends StatelessWidget {
  /// [ListView] со списком проектов и кнопками для удаления, изменения имени проекта и добавлением/удалением признака [favorite].
  const ListProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopListProject(),
          SizedBox(height: 10),
          Expanded(child: CardProject()),
        ],
      ),
    );
  }
}
