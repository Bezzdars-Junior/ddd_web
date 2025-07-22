import 'dart:convert';

import 'package:ddd/screens/main_screen/entity/project.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelMain extends ChangeNotifier {
  String? sortValue = 'Имя(по убыв.)';
  String? sortFavoriteValue = 'Имя(по убыв.)';
  List<Project> projects = [];
  List<Project> favouriteProjects = [];

  /// метод для получения списка [Project] из БД.
  Future<String> initProjects({required BuildContext context}) async {
    final url = Uri.parse('http://localhost:8080/main_page');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = await jsonDecode(response.body) as List<dynamic>;
        final posts = json.map((e) => Project.fromJson(e)).toList();
        for (final Project project in posts) {
          listDistribution(project);
        }
      } else {
        throw Exception('Сервер вернул ошибку: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Не удалось подключиться к серверу');
    }

    return 'String';
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
    final url = Uri.parse('http://localhost:8080/main_page');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'projectName': nameProject,
      'description': descriptionProject,
      'favourite': false,
      'image': imageProject
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      final json = await jsonDecode(response.body) as Map<String, dynamic>;
      final project = Project.fromJson(json);
      Navigator.of(context).pop();
      listDistribution(project);
      notifyListeners();
    } catch (error) {
      errorAlert(context, error);
    }
  }

  /// Удалить проект из БД.
  void deleteProject(
      {required Project project,
      required int index,
      required BuildContext context}) async {
    final url = Uri.parse('http://localhost:8080/main_page/${project.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = {};
    try {
      await http.delete(
        url,
        headers: headers,
        body: jsonEncode(body), // Кодируем тело в JSON
      );
      if (project.favourite) {
        favouriteProjects.removeAt(index);
      } else {
        projects.removeAt(index);
      }
      notifyListeners();
    } catch (error) {
      print('hui');
      errorAlert(context, error);
    }
  }

  /// Изменить признак [favourite] у проекта.
  void switchFavourite(
      {required Project project,
      required int index,
      required BuildContext context}) async {
    final url = Uri.parse('http://localhost:8080/main_page/${project.id}');
    final headers = {'Content-Type': 'application/json'};
    Map<String, bool> body = {};
    try {
      if (!project.favourite) {
        projects[index].favourite = true;
        favouriteProjects.add(projects[index]);
        projects.removeAt(index);
        body = {'favourite': true};
      } else {
        favouriteProjects[index].favourite = false;
        projects.add(favouriteProjects[index]);
        favouriteProjects.removeAt(index);
        body = {'favourite': false};
      }
      await http.put(url, headers: headers, body: jsonEncode(body));
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
    final url = Uri.parse('http://localhost:8080/main_page/${project.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'projectName': nameProject,
      'description': descriptionProject,
      'image': imageProject,
    };
    try {
      await http.put(url, headers: headers, body: jsonEncode(body));
      if (project.favourite) {
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
        content: Text(error.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
