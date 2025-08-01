import '../../../api/api_client.dart';
import '../export_widgets.dart';

class ModelMain extends ChangeNotifier {
  final _apiClient = ApiClient();
  String? sortValue = 'Имя(по убыв.)';
  String? sortFavoriteValue = 'Имя(по убыв.)';
  final searchString = TextEditingController();

  List<Project> projects = [];

  List<Project> favouriteProjects = [];

  /// метод для получения списка [Project] из БД.
  Future<String> initProjects() async {
    try {
      final projectsFromBD = await _apiClient.getProjects();
      for (final Project project in projectsFromBD) {
        listDistribution(project);
      }
      return 'String';
    } catch (e) {
      throw Exception();
    }
  }

  /// [AlertDialog] для добавления нового проекта.
  void addProject(BuildContext context) {
    final controllerNameProject = TextEditingController();
    final controllerDescriptionProject = TextEditingController();
    final controllerImageProject = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(child: Text('Создание нового проекта')),
        content: SizedBox(
          height: 500,
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Введите название нового проекта'),
              TextField(controller: controllerNameProject),
              const SizedBox(height: 10),
              const Text('Введите описание проекта'),
              TextField(
                controller: controllerDescriptionProject,
                maxLines: 4,
              ),
              const SizedBox(height: 10),
              const Text('Введите ссылку на картинку'),
              TextField(controller: controllerImageProject),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => saveNewProject(
              context: context,
              nameProject: controllerNameProject.text,
              descriptionProject: controllerDescriptionProject.text,
              imageProject: controllerImageProject.text,
            ),
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Сохранить новый проект в БД.
  void saveNewProject({
    required BuildContext context,
    required String nameProject,
    required String descriptionProject,
    required String imageProject,
  }) async {
    final body = {
      'projectName': nameProject,
      'description': descriptionProject,
      'favourite': false,
      'image': imageProject
    };
    try {
      final project = await _apiClient.postProject(body);
      listDistribution(project);
      Navigator.of(context).pop();
      notifyListeners();
    } catch (error) {
      errorAlert(context, error);
    }
  }

  /// Удалить проект из БД.
  void deleteProject({
    required Project project,
    required int index,
    required BuildContext context,
  }) async {
    final path = '/${project.id}';
    try {
      await _apiClient.deleteProject(path);
      if (project.favourite) {
        favouriteProjects.removeAt(index);
      } else {
        projects.removeAt(index);
      }
      notifyListeners();
    } catch (error) {
      errorAlert(context, error);
    }
  }

  /// Изменить признак [favourite] у проекта.
  void switchFavourite({
    required Project project,
    required int index,
    required BuildContext context,
  }) async {
    try {
      final path = '/${project.id}';
      Map<String, bool> body = {};

      if (!project.favourite) {
        body = {'favourite': true};
        projects.removeAt(index);
      } else {
        body = {'favourite': false};
        favouriteProjects.removeAt(index);
      }
      final changedProject = await _apiClient.putProject(path, body);
      listDistribution(changedProject);
      notifyListeners();
    } catch (error) {
      errorAlert(context, error);
    }
  }

  /// [AlertDialog] для переименование проекта.
  void changeProject({
    required BuildContext context,
    required int index,
    required Project project,
  }) {
    final controllerNameProject = TextEditingController();
    final controllerDescriptionProject = TextEditingController();
    final controllerImageProject = TextEditingController();
    controllerNameProject.text = project.projectName;
    controllerDescriptionProject.text = project.description;
    controllerImageProject.text = project.image;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(child: Text('Переименовать проект')),
        content: SizedBox(
          height: 500,
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Введите новое имя проекта'),
              TextField(controller: controllerNameProject),
              const SizedBox(height: 10),
              const Text('Введите новое описание проекта'),
              TextField(controller: controllerDescriptionProject),
              const SizedBox(height: 10),
              const Text('Введите новую ссылку на картинку'),
              TextField(controller: controllerImageProject),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => saveRenamedProject(
              context: context,
              project: project,
              index: index,
              nameProject: controllerNameProject.text,
              descriptionProject: controllerDescriptionProject.text,
              imageProject: controllerImageProject.text,
            ),
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Сохранить измененное имя в БД.
  void saveRenamedProject({
    required BuildContext context,
    required Project project,
    required int index,
    required String nameProject,
    required String descriptionProject,
    required String imageProject,
  }) async {
    final body = {
      'projectName': nameProject,
      'description': descriptionProject,
      'image': imageProject,
    };
    final path = '/${project.id}';
    try {
      final response = await _apiClient.putProject(path, body);
      if (response.favourite) {
        favouriteProjects[index].projectName = nameProject;
        favouriteProjects[index].description = descriptionProject;
        favouriteProjects[index].image = imageProject;
      } else {
        projects[index].projectName = nameProject;
        projects[index].description = descriptionProject;
        projects[index].image = imageProject;
      }
      Navigator.of(context).pop();
      notifyListeners();
    } catch (error) {
      errorAlert(context, error);
    }
  }

  void sortProjects(String? value) {
    sortValue = value;
    if (value == 'Имя(по убыв.)') {
      projects.sort((a, b) => b.projectName.compareTo(a.projectName));
    } else if (value == 'Имя(по возр.)') {
      projects.sort((a, b) => a.projectName.compareTo(b.projectName));
    } else if (value == 'Дата(по убыв.)') {
      projects.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    } else if (value == 'Дата(по возр.)') {
      projects.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    notifyListeners();
  }

  void sortFavoriteProjects(String? value) {
    sortFavoriteValue = value;
    if (value == 'Имя(по убыв.)') {
      favouriteProjects.sort((a, b) => b.projectName.compareTo(a.projectName));
    } else if (value == 'Имя(по возр.)') {
      favouriteProjects.sort((a, b) => a.projectName.compareTo(b.projectName));
    } else if (value == 'Дата(по убыв.)') {
      favouriteProjects.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    } else if (value == 'Дата(по возр.)') {
      favouriteProjects.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    notifyListeners();
  }

  void listDistribution(Project newProject) {
    if (newProject.favourite) {
      favouriteProjects.add(newProject);
    } else {
      projects.add(newProject);
    }
  }

  void errorAlert(BuildContext context, Object error) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка на сервере'),
        content: Text('Ошибка. Попробуйте позже. Ошибка: ${error.toString()}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void searchProject(BuildContext context) async {
    try {
      if (searchString.text.isNotEmpty) {
        final response = await _apiClient
            .getProjects('/search?projectName=${searchString.text}');
        projects =
            response.where((Project project) => !project.favourite).toList();
      } else {
        final response = await _apiClient.getProjects();
        projects =
            response.where((Project project) => !project.favourite).toList();
      }
      notifyListeners();
    } catch (error) {
      errorAlert(context, error);
    }
  }
}
