import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  /// Кнопка для сохранения изменений в базу данных.
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return Tooltip(
      message: 'Сохранить все изменения в базу данных',
      child: TextButton(
        onPressed: model.saveDataBase,
        style: const ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll(Color.fromARGB(255, 172, 37, 160)),
        ),
        child: const Center(
          child: Text(
            'Сохранить изменения',
            style: TextStyle(
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
