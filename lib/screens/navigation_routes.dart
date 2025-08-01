import 'main_screen/export_widgets.dart';

abstract class NavigationRoutes {
  static const mainScreen = '/';
  static const projectScreen = '/project';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRoutes.mainScreen: (context) => const MainScreen(),
    NavigationRoutes.projectScreen: (context) => const ProjectScreen(),
  };
}
