import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/model_main.dart';
import 'widgets/header_main_screen/header_main_screen.dart';
import 'widgets/list_favourite_project/list_favorite_projects.dart';
import 'widgets/list_project/list_projects.dart';
import 'widgets/loading_app_widget.dart';

class MainScreenBodyWidget extends StatefulWidget {
  const MainScreenBodyWidget({super.key});

  @override
  State<MainScreenBodyWidget> createState() => _MainScreenBodyWidgetState();
}

class _MainScreenBodyWidgetState extends State<MainScreenBodyWidget> {
  late final Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    final model = context.read<ModelMain>();
    _initializationFuture = model.initProjects(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return FutureBuilder(
      future: _initializationFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Ошибка'),
                content: const Text(
                  'Сервер временно не работает. Пожалуйста, попробуйте позже.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          });
        } else if (snapshot.hasData) {
          return Column(
            children: [
              const HeaderMainScreen(),
              Expanded(
                child: Column(
                  children: [
                    if (model.favouriteProjects.isNotEmpty)
                      const Expanded(
                        flex: 3,
                        child: ListFavouriteProjects(),
                      ),
                    const Expanded(
                      flex: 8,
                      child: ListProjects(),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const LoadingAppWidget();
      },
    );
  }
}
