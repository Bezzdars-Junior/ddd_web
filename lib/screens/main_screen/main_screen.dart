import 'export_widgets.dart';

/// Главная странница со списком проектов.
class MainScreen extends StatelessWidget {
  /// Конструктор [MainScreen].
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelMain(),
      child: const Scaffold(
        body: MainScreenBodyWidget(),
      ),
    );
  }
}
