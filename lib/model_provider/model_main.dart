import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/entity/feature.dart';
import 'package:ddd/entity/project.dart';
import 'package:flutter/material.dart';

class ModelMain extends ChangeNotifier {
  List<Project> projects = [];
  bool firstInitial = true;
  int countProjectsDataBase = 0;
  TextEditingController controllerNameNewProject = TextEditingController();

  Future<String> initProjects() async {
    if (firstInitial) {
      final db = FirebaseFirestore.instance;
      await db.collection('projects').get().then((docs) {
        countProjectsDataBase = docs.docs.length;
      });
      for (int i = 0; i < countProjectsDataBase; i++) {
        final ref = db.collection('projects').doc('$i').withConverter(
            fromFirestore: Project.fromFirestore,
            toFirestore: (Project projects, _) => projects.toFirestore());
        final docSnap = await ref.get();
        final project = docSnap.data();
        if (project != null) {
          projects.add(project);
        }
      }
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
                onPressed: () => saveNewFeature(context),
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

  void saveNewFeature(context) async {
    final db = FirebaseFirestore.instance;
    projects.add(
        Project(projectName: controllerNameNewProject.text, favorite: 'false'));
    Navigator.of(context).pop();
    notifyListeners();
    final docRef = db
        .collection('projects')
        .withConverter(
          fromFirestore: Project.fromFirestore,
          toFirestore: (Project project, _) => project.toFirestore(),
        )
        .doc('${projects.length - 1}');
    await docRef.set(
        Project(projectName: controllerNameNewProject.text, favorite: 'false'));
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

  void deleteProject(int index) {
    final db = FirebaseFirestore.instance;
    db.collection(projects[index].projectName).get().then((snapshot) {
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
        .doc('$index');
    docRef.delete();
    projects.removeAt(index);
    notifyListeners();
  }

  void addFavorite(int index) {
    final db = FirebaseFirestore.instance;
    db.collection('projects').doc('$index').update({"favorite": 'true'});

    if (projects[index].favorite == 'false') {
      projects[index].favorite = 'true';
      db.collection('projects').doc('$index').update({"favorite": 'true'});
    } else {
      projects[index].favorite = 'false';
      db.collection('projects').doc('$index').update({"favorite": 'false'});
    }

    projects.sort((a, b) => b.favorite.compareTo(a.favorite));
    for (int i = 0; i < projects.length; i++) {
      db
          .collection('projects')
          .withConverter(
            fromFirestore: Project.fromFirestore,
            toFirestore: (Project project, _) => project.toFirestore(),
          )
          .doc('$i')
          .set(projects[i]);
    }
    notifyListeners();
  }
}
