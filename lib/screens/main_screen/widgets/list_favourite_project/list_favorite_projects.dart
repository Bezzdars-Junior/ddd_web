import '../../export_widgets.dart';

class ListFavouriteProjects extends StatelessWidget {
  const ListFavouriteProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const TopListFavouriteProject(),
          const SizedBox(height: 10),
          Expanded(
            child: TableCardProject(projects: model.favouriteProjects),
          ),
        ],
      ),
    );
  }
}
