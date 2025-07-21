import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/model_main.dart';
import '../dropdown_button_widget.dart';

class TopListFavouriteProject extends StatelessWidget {
  const TopListFavouriteProject({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Избранные проекты:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DropdownButtonWidget(projects: model.favouriteProjects),
      ],
    );
  }
}
