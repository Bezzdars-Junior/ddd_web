import 'package:ddd/model_provider/model_project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconButtonStyle extends StatelessWidget {
  final VoidCallback func;
  final IconData icon;
  final String message;

  /// Общая кнопка с иконкой.
  const IconButtonStyle({
    required this.func,
    required this.icon,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelProject>();
    return Tooltip(
      message: message,
      child: IconButton(
        onPressed: (model.indexCurrentFeature == null) ? null : func,
        icon: Icon(icon),
      ),
    );
  }
}
