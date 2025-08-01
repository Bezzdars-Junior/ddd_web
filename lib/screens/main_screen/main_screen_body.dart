import 'export_widgets.dart';

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
    _initializationFuture = model.initProjects();
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
