import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColumnFooter extends StatelessWidget {
  /// Flex при сворачивании, для отображения иконки
  final bool isFlex;
  final String nameColumn;
  final int countIndex;
  final int indexCurrentPartFeature;

  const ColumnFooter({
    required this.isFlex,
    required this.nameColumn,
    required this.countIndex,
    required this.indexCurrentPartFeature,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return isFlex
        ? const Text('')
        : Expanded(
            child: Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: countIndex,
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              (index == indexCurrentPartFeature)
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                        onPressed: () =>
                            model.changePartFeature(index, nameColumn),
                        child: Text(
                          '${index + 1}',
                        ),
                      );
                    },
                  ),
                ),
                IconButtonStyle(
                  func: () => model.addPartFeature(nameColumn),
                  icon: Icons.add,
                ),
                IconButtonStyle(
                  func: () => model.deletePartFeature(nameColumn),
                  icon: Icons.delete,
                ),
                IconButtonStyle(
                  func: () => model.editingColumn(nameColumn),
                  icon: Icons.create,
                ),
                const SizedBox(width: 5),
              ],
            ),
          );
  }
}
