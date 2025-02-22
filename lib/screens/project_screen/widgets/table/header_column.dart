import 'package:ddd/general_widgets/icon_button_style.dart';
import 'package:ddd/model_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderColumn extends StatelessWidget {
  final bool isFlex;
  final IconData icon;
  final String nameColumn;
  final String dataTextNameColumn;

  const HeaderColumn({
    required this.isFlex,
    required this.icon,
    required this.nameColumn,
    required this.dataTextNameColumn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return SizedBox(
      height: 50,
      child: isFlex
          ? IconButtonStyle(
              func: () => model.changeFlex(nameColumn),
              icon: icon,
            )
          : TextButton(
              child: Text(
                dataTextNameColumn,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                ),
              ),
              onPressed: () => model.changeFlex(nameColumn),
            ),
    );
  }
}
