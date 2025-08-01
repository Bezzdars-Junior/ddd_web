import '../../export_widgets.dart';

class TopListProject extends StatelessWidget {
  const TopListProject({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return Row(
      children: [
        const Text(
          'Все проекты',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => model.addProject(context),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Container(
            color: Colors.white,
            child: TextField(
              controller: model.searchString,
              decoration: const InputDecoration(
                hintText: 'Поисковая строка',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () => model.searchProject(context),
          icon: const Icon(Icons.search),
        ),
        const SizedBox(width: 30),
        DropdownButtonWidget(
            projects: model.projects, sortValue: model.sortValue),
      ],
    );
  }
}
