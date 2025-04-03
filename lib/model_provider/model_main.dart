import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/entity/feature.dart';
import 'package:ddd/entity/project.dart';
import 'package:flutter/material.dart';

class ModelMain extends ChangeNotifier {
  List<Project> projects = [];
  bool firstInitial = true;
  int countProjectsDataBase = 0;
  TextEditingController controllerNameNewProject = TextEditingController();
  TextEditingController controllerEditedNameProject = TextEditingController();

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
          .then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            projects.add(docSnapshot.data());
          }
        },
      );
      projects.sort((a, b) => b.favorite.compareTo(a.favorite));
      firstInitial = false;
      return 'Data Loaded';
    }
    return 'Second initial';
  }

  /// [AlertDialog] для добавления нового проекта.
  addProject(context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Center(
            child: Text('Создание нового проекта'),
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text('Введите название нового проекта'),
                TextField(controller: controllerNameNewProject),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => saveNewProject(context),
                child: const Text('Save')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controllerNameNewProject.text = '';
                },
                child: const Text('Cancel'))
          ],
        ),
      );

  /// Сохранить новый проект в БД.
  void saveNewProject(context) async {
    final db = FirebaseFirestore.instance;
    late String id;
    final docRef = db.collection('projects').withConverter(
          fromFirestore: Project.fromFirestore,
          toFirestore: (Project project, _) => project.toFirestore(),
        );
    await docRef
        .add(Project(
      projectName: controllerNameNewProject.text,
      favorite: 'false',
      dateTime: DateTime.now().toString(),
      id: '',
      viewName: controllerNameNewProject.text,
    ))
        .then((documentSnapshot) {
      id = documentSnapshot.id;
      db
          .collection('projects')
          .doc(documentSnapshot.id)
          .update({'id': documentSnapshot.id});
    });
    projects.add(Project(
      projectName: controllerNameNewProject.text,
      favorite: 'false',
      dateTime: DateTime.now().toString(),
      id: id,
      viewName: controllerNameNewProject.text,
    ));
    notifyListeners();
    Navigator.of(context).pop();
    final docRefProject = db
        .collection(controllerNameNewProject.text)
        .withConverter(
          fromFirestore: Feature.fromFirestore,
          toFirestore: (Feature feature, _) => feature.toFirestore(),
        )
        .doc('0');
    await docRefProject.set(Feature(
        anal: [''],
        dev: [''],
        test: [''],
        featureName: controllerNameNewProject.text,
        dateTime: '0',
        favorite: 'false'));
    controllerNameNewProject.text = '';
  }

  /// Удалить проект из БД.
  void deleteProject({required Project project, required int index}) {
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
    projects.removeAt(index);
    notifyListeners();
  }

  /// Изменить признак [favorite] у проекта.
  void switchFavorite(String idProject, int index) {
    final db = FirebaseFirestore.instance;
    if (projects[index].favorite == 'false') {
      projects[index].favorite = 'true';
      db.collection('projects').doc(idProject).update({"favorite": 'true'});
    } else {
      projects[index].favorite = 'false';
      db.collection('projects').doc(idProject).update({"favorite": 'false'});
    }

    projects.sort((a, b) => b.favorite.compareTo(a.favorite));
    notifyListeners();
  }

  /// Отсортировать список проектов по имени.
  void sortName() {
    List<Project> favorites = [];
    List<Project> other = [];
    for (Project element in projects) {
      if (element.favorite == 'true') {
        favorites.add(element);
      } else {
        other.add(element);
      }
    }
    other.sort((a, b) => a.viewName.compareTo(b.viewName));
    projects = [...favorites, ...other];

    notifyListeners();
  }

  /// Отсортировать список проектов по времени создания.
  void sortTime() {
    List<Project> favorites = [];
    List<Project> other = [];
    for (Project element in projects) {
      if (element.favorite == 'true') {
        favorites.add(element);
      } else {
        other.add(element);
      }
    }
    other.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    projects = [...favorites, ...other];
    notifyListeners();
  }

  /// [AlertDialog] для переименование проекта.
  void renameProject(
      {required BuildContext context,
      required int index,
      required Project project}) {
    controllerEditedNameProject.text = project.viewName;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
          child: Text('Переименовать фичу'),
        ),
        content: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Введите новое имя проекта'),
              TextField(controller: controllerEditedNameProject),
              Text('ID проекта в БД: ${project.projectName}')
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => saveRenamedProject(context, project.id, index),
              child: const Text('Save')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controllerEditedNameProject.text = '';
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }

  /// Сохранить измененное имя в БД.
  void saveRenamedProject(BuildContext context, String idProject, int index) {
    final db = FirebaseFirestore.instance;
    db
        .collection('projects')
        .doc(idProject)
        .update({"viewName": controllerEditedNameProject.text});
    projects[index].viewName = controllerEditedNameProject.text;
    Navigator.of(context).pop();
    notifyListeners();
  }
}
