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

  void saveNewProject(context) async {
    /// Добавляем проект в базу данных
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
      dataTime: DateTime.now().toString(),
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
      dataTime: DateTime.now().toString(),
      id: id,
      viewName: controllerNameNewProject.text,
    ));
    notifyListeners();
    Navigator.of(context).pop();

    /// Создаем пустой проект в базе данных
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

  void deleteProject(
      {required String idProject,
      required String projectName,
      required int index}) {
    final db = FirebaseFirestore.instance;
    db.collection(projectName).get().then((snapshot) {
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
        .doc(idProject);
    docRef.delete();
    projects.removeAt(index);
    notifyListeners();
  }

  void addFavorite(String idProject, int index) {
    final db = FirebaseFirestore.instance;
    // db.collection('projects').doc(idProject).update({"favorite": 'true'});

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
    other.sort((a, b) => b.dataTime.compareTo(a.dataTime));
    projects = [...favorites, ...other];
    notifyListeners();
  }

  void renameProjectAlertDialog(
      {required BuildContext context,
      required String idProject,
      required String projectBDname,
      required String currentName,
      required int index}) {
    controllerEditedNameProject.text = currentName;
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
              Text('ID проекта в БД: ${projectBDname}')
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => renameProject(context, idProject, index),
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

  void renameProject(BuildContext context, String idProject, int index) {
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
