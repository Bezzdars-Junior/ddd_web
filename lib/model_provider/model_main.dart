import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/entity/feature.dart';
import 'package:ddd/entity/project.dart';
import 'package:flutter/material.dart';

class ModelMain extends ChangeNotifier {
  String? sortValue = 'Имя(по убыв.)';
  String? sortFavoriteValue = 'Имя(по убыв.)';

  
  List<Project> projects = [];
  List<Project> favoriteProjects = [];
  bool firstInitial = true;
  int countProjectsDataBase = 0;
  TextEditingController controllerNameProject = TextEditingController();
  TextEditingController controllerDescriptionProject = TextEditingController();

 

  /// метод для получения списка [Project] из БД.
  Future<String> initProjects() async {
    if (firstInitial) {
      final db = FirebaseFirestore.instance;
      await db
          .collection("projects")
          .withConverter(
            fromFirestore: Project.fromFirestore,
            toFirestore: (Project project, _) => project.toFirestore(),
          )
          .get()
          .then((querySnapshot) {
            for (var docSnapshot in querySnapshot.docs) {
              if (docSnapshot.data().favorite == 'false') {
                projects.add(docSnapshot.data());
              } else {
                favoriteProjects.add(docSnapshot.data());
              }
            }
          });

      firstInitial = false;
      return 'Data Loaded';
    }
    return 'Second initial';
  }

  /// [AlertDialog] для добавления нового проекта.
  addProject(context) => showDialog<String>(
    context: context,
    builder:
        (BuildContext context) => AlertDialog(
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
  void saveNewProject(context) async {
    final db = FirebaseFirestore.instance;
    late String id;
    final docRef = db
        .collection('projects')
        .withConverter(
          fromFirestore: Project.fromFirestore,
          toFirestore: (Project project, _) => project.toFirestore(),
        );
    await docRef
        .add(
          Project(
            projectName: controllerNameProject.text,
            favorite: 'false',
            dateTime: DateTime.now()
                .toString()
                .split(" ")[0]
                .replaceAll('-', '.'),
            id: '',
            viewName: controllerNameProject.text,
            description: controllerDescriptionProject.text,
            dateChange: DateTime.now()
                .toString()
                .split(" ")[0]
                .replaceAll('-', '.'),
          ),
        )
        .then((documentSnapshot) {
          id = documentSnapshot.id;
          db.collection('projects').doc(documentSnapshot.id).update({
            'id': documentSnapshot.id,
          });
        });
    projects.add(
      Project(
        projectName: controllerNameProject.text,
        favorite: 'false',
        dateTime: DateTime.now().toString().split(" ")[0].replaceAll('-', '.'),
        id: id,
        viewName: controllerNameProject.text,
        description: controllerDescriptionProject.text,
        dateChange: DateTime.now()
            .toString()
            .split(" ")[0]
            .replaceAll('-', '.'),
      ),
    );
    notifyListeners();
    Navigator.of(context).pop();
    final docRefProject = db
        .collection(controllerNameProject.text)
        .withConverter(
          fromFirestore: Feature.fromFirestore,
          toFirestore: (Feature feature, _) => feature.toFirestore(),
        )
        .doc('0');
    await docRefProject.set(
      Feature(
        anal: [''],
        dev: [''],
        test: [''],
        featureName: controllerNameProject.text,
        dateTime: '0',
        favorite: 'false',
      ),
    );
    controllerNameProject.text = '';
    controllerDescriptionProject.text = '';
  }

  /// Удалить проект из БД.
  void deleteProject({
    required Project project,
    required int index,
    required String favorite,
  }) {
    final db = FirebaseFirestore.instance;

    db.collection(project.projectName).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    final docRef = db
        .collection('projects')
        .withConverter(
          fromFirestore: Project.fromFirestore,
          toFirestore: (Project project, _) => project.toFirestore(),
        )
        .doc(project.id);
    docRef.delete();
    if (favorite == 'true') {
      favoriteProjects.removeAt(index);
    } else {
      projects.removeAt(index);
    }

    notifyListeners();
  }

  /// Изменить признак [favorite] у проекта.
  void switchFavorite(String idProject, int index, String favorite) {
    final db = FirebaseFirestore.instance;
    if (favorite == 'false') {
      projects[index].favorite = 'true';
      favoriteProjects.add(projects[index]);
      projects.removeAt(index);
      db.collection('projects').doc(idProject).update({"favorite": 'true'});
    } else {
      favoriteProjects[index].favorite = 'false';
      projects.add(favoriteProjects[index]);
      favoriteProjects.removeAt(index);
      db.collection('projects').doc(idProject).update({"favorite": 'false'});
    }

    notifyListeners();
  }

  /// [AlertDialog] для переименование проекта.
  void changeProject({
    required BuildContext context,
    required int index,
    required Project project,
    required String favorite,
  }) {
    controllerNameProject.text = project.viewName;
    controllerDescriptionProject.text = project.description;
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
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
                onPressed:
                    () => saveRenamedProject(
                      context,
                      project.id,
                      index,
                      favorite,
                    ),
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
    String idProject,
    int index,
    String favorite,
  ) {
    final db = FirebaseFirestore.instance;
    db.collection('projects').doc(idProject).update({
      "viewName": controllerNameProject.text,
      "description": controllerDescriptionProject.text,
      "dateChange": DateTime.now()
          .toString()
          .split(" ")[0]
          .replaceAll('-', '.'),
    });
    if (favorite == 'true') {
      favoriteProjects[index].viewName = controllerNameProject.text;
      favoriteProjects[index].description = controllerDescriptionProject.text;
    } else {
      projects[index].viewName = controllerNameProject.text;
      projects[index].description = controllerDescriptionProject.text;
    }
    controllerNameProject.text = '';
    controllerDescriptionProject.text = '';
    Navigator.of(context).pop();
    notifyListeners();
  }

  sortProjects(String? value) {
    sortValue = value;
    if (value == 'Имя(по убыв.)') {
      projects.sort((a, b) => b.viewName.compareTo(a.viewName));
    } else if (value == 'Имя(по возр.)') {
      projects.sort((a, b) => a.viewName.compareTo(b.viewName));
    } else if (value == 'Дата(по убыв.)') {
      projects.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    } else if (value == 'Дата(по возр.)') {
      projects.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    notifyListeners();
  }

  sortFavoriteProjects(String? value) {
    sortFavoriteValue = value;
    if (value == 'Имя(по убыв.)') {
      favoriteProjects.sort((a, b) => b.viewName.compareTo(a.viewName));
    } else if (value == 'Имя(по возр.)') {
      favoriteProjects.sort((a, b) => a.viewName.compareTo(b.viewName));
    } else if (value == 'Дата(по убыв.)') {
      favoriteProjects.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    } else if (value == 'Дата(по возр.)') {
      favoriteProjects.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }
    notifyListeners();
  }
}
