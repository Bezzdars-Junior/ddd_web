import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColumnBody extends StatelessWidget {
  final bool isFlex;
  final bool isReadNameColumn;
  final TextEditingController controller;
  final String nameColumn;
  final Widget markdown;
  final IconData icon;

  const ColumnBody({
    required this.isFlex,
    required this.isReadNameColumn,
    required this.controller,
    required this.nameColumn,
    required this.markdown,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return isFlex
        ? const Text('')
        : isReadNameColumn
            ? Expanded(
                flex: 15,
                child: ListView(
                  children: [
                    Center(
                      child: markdown,
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  TextField(
                    controller: controller,
                    maxLines: 33,
                  ),
                  IconButtonStyle(
                    func: () => model.saveEditedColumn(nameColumn),
                    icon: icon,
                  )
                ],
              );
  }
}
