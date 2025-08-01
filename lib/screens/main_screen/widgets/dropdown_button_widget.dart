import '../export_widgets.dart';

class DropdownButtonWidget extends StatelessWidget {
  final List<Project> projects;
  const DropdownButtonWidget({
    required this.projects,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelMain>();
    return DropdownButton(
      value: model.sortValue,
      items: [
        'Имя(по возр.)',
        'Имя(по убыв.)',
        'Дата(по возр.)',
        'Дата(по убыв.)',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) => model.sortProjects(value),
    );
  }
}
