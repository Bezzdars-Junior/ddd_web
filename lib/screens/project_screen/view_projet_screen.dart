import 'package:ddd/model_provider/model.dart';
import 'package:ddd/screens/project_screen/widgets/left_column/left_column.dart';
import 'package:ddd/screens/project_screen/widgets/table/table_project_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Виджет с версткой страницы проекта.
class ViewProjectScreen extends StatelessWidget {
  /// Коструктор [ViewProjectScreen].
  const ViewProjectScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    return FutureBuilder(
        future: model.initFeature(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                children: [
                  const Expanded(
                    child: LeftColumn(),
                  ),
                  Container(
                    color: Colors.black,
                    width: 1,
                    height: double.infinity,
                  ),
                  const Expanded(
                    flex: 10,
                    child: TableProjectScreen(),
                  )
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
