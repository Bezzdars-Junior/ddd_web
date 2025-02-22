import 'package:ddd/modelProvider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconButtonStyle extends StatelessWidget {
  final VoidCallback? func;
  final IconData? icon;

  /// Общая кнопка с иконкой.
  const IconButtonStyle({
    required this.func,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return IconButton(
      onPressed: (model.indexCurrentFeature == null) ? null : func,
      icon: Icon(icon),
    );
  }
}
