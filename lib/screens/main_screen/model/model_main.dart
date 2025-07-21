import 'dart:convert';

import 'package:ddd/screens/main_screen/entity/project.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelMain extends ChangeNotifier {
  String? sortValue = 'Имя(по убыв.)';
  String? sortFavoriteValue = 'Имя(по убыв.)';
  List<Project> projects = [];
  List<Project> favouriteProjects = [];
  int countProjectsDataBase = 0;
  TextEditingController controllerNameProject = TextEditingController();
  TextEditingController controllerDescriptionProject = TextEditingController();

  /// метод для получения списка [Project] из БД.
  Future<String> initProjects() async {
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
        print('${response.statusCode}');
      }
    } catch (e) {}

    return 'String';
  }

  /// [AlertDialog] для добавления нового проекта.
  void addProject(BuildContext context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Center(child: Text('Создание нового проекта')),
          content: SizedBox(
            height: 300,
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => saveNewProject(context),
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controllerNameProject.text = '';
                controllerDescriptionProject.text = '';
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );

  /// Сохранить новый проект в БД.
  void saveNewProject(BuildContext context) async {
    final url = Uri.parse('http://localhost:8080/main_page');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'projectName': controllerNameProject.text,
      'description': controllerDescriptionProject.text,
      'favourite': false,
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      final json = await jsonDecode(response.body) as Map<String, dynamic>;
      final post = Project.fromJson(json);
      listDistribution(post);
      notifyListeners();
    } catch (error) {
      errorAlert(context, error);
    }
  }

  /// Удалить проект из БД.
  void deleteProject({required Project project, required int index}) async {
    final url = Uri.parse('http://localhost:8080/main_page/${project.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = {};
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
  }

  /// Изменить признак [favourite] у проекта.
  void switchFavourite(Project project, int index) async {
    final url = Uri.parse('http://localhost:8080/main_page/${project.id}');
    final headers = {'Content-Type': 'application/json'};
    Map<String, bool> body = {};
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
  }

  /// [AlertDialog] для переименование проекта.
  void changeProject({
    required BuildContext context,
    required int index,
    required Project project,
  }) {
    controllerNameProject.text = project.projectName;
    controllerDescriptionProject.text = project.description;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(child: Text('Переименовать фичу')),
        content: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Введите новое имя проекта'),
              TextField(controller: controllerNameProject),
              Text('ID проекта в БД: ${project.projectName}'),
              const SizedBox(height: 10),
              const Text('Введите новое описание проекта'),
              TextField(controller: controllerDescriptionProject),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => saveRenamedProject(context, project, index),
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controllerNameProject.text = '';
              controllerDescriptionProject.text = '';
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Сохранить измененное имя в БД.
  void saveRenamedProject(
    BuildContext context,
    Project project,
    int index,
  ) async {
    final url = Uri.parse('http://localhost:8080/main_page/${project.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'projectName': '${controllerNameProject.text}',
      'description': '${controllerDescriptionProject.text}',
    };
    await http.put(url, headers: headers, body: jsonEncode(body));
    if (project.favourite) {
      favouriteProjects[index].projectName = controllerNameProject.text;
      favouriteProjects[index].description = controllerDescriptionProject.text;
    } else {
      projects[index].projectName = controllerNameProject.text;
      projects[index].description = controllerDescriptionProject.text;
    }
    controllerNameProject.text = '';
    controllerDescriptionProject.text = '';
    Navigator.of(context).pop();
    notifyListeners();
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
}
