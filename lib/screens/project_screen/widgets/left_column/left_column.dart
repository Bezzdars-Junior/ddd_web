import 'package:ddd/screens/project_screen/widgets/left_column/bottom_buttons_left_column.dart';
import 'package:ddd/screens/project_screen/widgets/left_column/buttons_sort.dart';
import 'package:ddd/screens/project_screen/widgets/left_column/header_left_column.dart';
import 'package:ddd/screens/project_screen/widgets/left_column/list_feature.dart';
import 'package:ddd/screens/project_screen/widgets/left_column/save_button.dart';
import 'package:flutter/material.dart';

class LeftColumn extends StatelessWidget {
  const LeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderLeftColumn(),
        Container(
          height: 1,
          color: Colors.black,
        ),
        const ButtonsSort(),
        const Expanded(
          child: ListFeature(),
        ),
        const SaveButton(),
        const BottomButtonsLeftColumn()
      ],
    );
  }
}
