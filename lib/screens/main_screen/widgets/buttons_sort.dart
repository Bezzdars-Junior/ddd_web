import 'package:ddd/model_provider/model_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonsSortProjects extends StatelessWidget {
  const ButtonsSortProjects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: model.sortName, icon: const Icon(Icons.abc)),
        IconButton(
            onPressed: model.sortTime, icon: const Icon(Icons.lock_clock)),
      ],
    );
  }
}
