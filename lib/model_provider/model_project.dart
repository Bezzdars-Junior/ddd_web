import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/entity/feature.dart';
import 'package:flutter/material.dart';

class ModelProject extends ChangeNotifier {
  int countFeaturesDataBase = 0;

  int flexAnal = 1;
  int flexDev = 1;
  int flexTest = 1;
  int? indexCurrentFeature;
  int indexCurrentPartAnalFeature = 0;
  int indexCurrentPartDevFeature = 0;
  int indexCurrentPartTestFeature = 0;
  bool readTest = true;
  bool readDev = true;
  bool readAnal = true;
  bool readNameFeature = true;
  bool firstInitial = true;
  final controllerNameForNewFeature = TextEditingController();
  final controllerFeatureName = TextEditingController();
  final controllerAnal = TextEditingController();
  final controllerDev = TextEditingController();
  final controllerTest = TextEditingController();
  List<Feature> features = [];

  /// Запрос на сервер для получения массива с [Feature].
  Future<String> initFeature(String nameProject) async {
    if (firstInitial) {
      final db = FirebaseFirestore.instance;

      await db.collection(nameProject).get().then((docs) {
        countFeaturesDataBase = docs.docs.length;
      });
      for (int i = 0; i < countFeaturesDataBase; i++) {
        final ref = db.collection(nameProject).doc('$i').withConverter(
            fromFirestore: Feature.fromFirestore,
            toFirestore: (Feature feature, _) => feature.toFirestore());
        final docSnap = await ref.get();
        final feature = docSnap.data();
        if (feature != null) {
          features.add(feature);
        }

        features.sort((a, b) => b.favorite.compareTo(a.favorite));
      }

      firstInitial = false;

      return 'Data Loaded';
    }
    return 'Second initial';
  }

  /// Сохранить данные лежащие в [features] в базу данных Firebase.
  void saveDataBase(String nameProject) async {
    final db = FirebaseFirestore.instance;
    if (countFeaturesDataBase > features.length) {
      for (int i = features.length; i <= countFeaturesDataBase; i++) {
        db.collection(nameProject).doc('$i').delete();
      }
    }
    for (int i = 0; i < features.length; i++) {
      final docRef = db
          .collection(nameProject)
          .withConverter(
            fromFirestore: Feature.fromFirestore,
            toFirestore: (Feature feature, _) => feature.toFirestore(),
          )
          .doc('$i');
      await docRef.set(features[i]);
    }
  }

  /// Сменить фичу.
  void changeFeature(int index) {
    indexCurrentFeature = index;
    indexCurrentPartAnalFeature = 0;
    indexCurrentPartDevFeature = 0;
    indexCurrentPartTestFeature = 0;
    notifyListeners();
  }

  /// Функция для свертывания/развертывания коллонки.
  /// Принимает [nameColumn] типа [String], которое определяет,
  /// какую коллонку свернуть/развернуть.
  void changeFlex(String nameColumn) {
    if (nameColumn == 'anal') {
      flexAnal == 1 ? flexAnal = 20 : flexAnal = 1;
      notifyListeners();
    }
    if (nameColumn == 'dev') {
      flexDev == 1 ? flexDev = 20 : flexDev = 1;
      notifyListeners();
    }
    if (nameColumn == 'test') {
      flexTest == 1 ? flexTest = 20 : flexTest = 1;
      notifyListeners();
    }
  }

  /// Функция вызывающая [AlertDialog] для добавления новой фичи в проект.
  addFeature(context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Center(
            child: Text('Создание новой фичи'),
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text('Введите название новой фичи'),
                TextField(controller: controllerNameForNewFeature),
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
                  controllerNameForNewFeature.text = '';
                },
                child: const Text('Cancel'))
          ],
        ),
      );

  /// Функция для удаления текущей фичи.
  void deleteCurrentFeature() {
    features.removeAt(indexCurrentFeature!);
    indexCurrentFeature = 0;
    notifyListeners();
  }

  /// Функция для сохранеия новой фичи для [AlertDialog].
  void saveNewFeature(context) {
    features.add(
      Feature(
        anal: [''],
        dev: [''],
        test: [''],
        featureName: controllerNameForNewFeature.text,
        dateTime: DateTime.now().toString(),
        favorite: 'false',
      ),
    );
    Navigator.of(context).pop();
    controllerNameForNewFeature.text = '';
    notifyListeners();
  }

  /// Добавить новую часть к коллонкею
  /// Принимает [nameColumn] типа [String], которое определяет,
  /// в какую коллонку добавить часть.
  void addPartFeature(String columnName) {
    if (columnName == 'anal') {
      features[indexCurrentFeature!].anal.add('');
    }
    if (columnName == 'dev') {
      features[indexCurrentFeature!].dev.add('');
    }
    if (columnName == 'test') {
      features[indexCurrentFeature!].test.add('');
    }
    notifyListeners();
  }

  /// Переключиться на другую часть коллонки.
  /// Принимает [nameColumn] типа [String], которое определяет,
  /// в какой коллонке переключаем часть.
  /// И [index] типа [int], которая определяет на какой номер части переключиться.
  void changePartFeature(int index, String columnName) {
    if (columnName == 'anal') {
      indexCurrentPartAnalFeature = index;
    }
    if (columnName == 'dev') {
      indexCurrentPartDevFeature = index;
    }
    if (columnName == 'test') {
      indexCurrentPartTestFeature = index;
    }
    notifyListeners();
  }

  /// Удалить текущую часть коллонки.
  /// Принимает [nameColumn] типа [String], которое определяет
  /// в какой коллонке удалить текущую часть.
  void deletePartFeature(String columnName) {
    if (columnName == 'anal') {
      features[indexCurrentFeature!].anal.removeAt(indexCurrentPartAnalFeature);
      indexCurrentPartAnalFeature = 0;
      if (features[indexCurrentFeature!].anal.isEmpty) {
        features[indexCurrentFeature!].anal.add('');
      }
    }
    if (columnName == 'dev') {
      features[indexCurrentFeature!].dev.removeAt(indexCurrentPartDevFeature);
      indexCurrentPartDevFeature = 0;
      if (features[indexCurrentFeature!].dev.isEmpty) {
        features[indexCurrentFeature!].dev.add('');
      }
    }
    if (columnName == 'test') {
      features[indexCurrentFeature!].test.removeAt(indexCurrentPartTestFeature);
      indexCurrentPartTestFeature = 0;
      if (features[indexCurrentFeature!].test.isEmpty) {
        features[indexCurrentFeature!].test.add('');
      }
    }
    notifyListeners();
  }

  /// Функция для отображения [TextField] и изменения текста в коллонке.
  void editingColumn(String columnName) {
    if (columnName == 'anal') {
      readAnal = false;
      controllerAnal.text =
          features[indexCurrentFeature!].anal[indexCurrentPartAnalFeature];
    }
    if (columnName == 'dev') {
      readDev = false;
      controllerDev.text =
          features[indexCurrentFeature!].dev[indexCurrentPartDevFeature];
    }
    if (columnName == 'test') {
      readTest = false;
      controllerTest.text =
          features[indexCurrentFeature!].test[indexCurrentPartTestFeature];
    }
    notifyListeners();
  }

  /// Функция для сохранения изменений в коллонке.
  void saveEditedColumn(String columnName) {
    if (columnName == 'anal') {
      features[indexCurrentFeature!].anal[indexCurrentPartAnalFeature] =
          controllerAnal.text;
      readAnal = true;
    }
    if (columnName == 'dev') {
      features[indexCurrentFeature!].dev[indexCurrentPartDevFeature] =
          controllerDev.text;
      readDev = true;
    }
    if (columnName == 'test') {
      features[indexCurrentFeature!].test[indexCurrentPartTestFeature] =
          controllerTest.text;
      readTest = true;
    }
    notifyListeners();
  }

  /// Функция для отображения [TextField] и изменения текста в названии фичи.
  void editingNameFeature() {
    readNameFeature = false;
    notifyListeners();
  }

  /// Ф-ция для сохранения нового имени фичи.
  void saveEditedNameFeature() {
    features[indexCurrentFeature!].featureName = controllerFeatureName.text;
    readNameFeature = true;
    notifyListeners();
  }

  /// Ф-ция для сортировки списка фичей по имени.
  void sortListName() {
    List<Feature> favorites = [];
    List<Feature> other = [];
    for (Feature element in features) {
      if (element.favorite == 'true') {
        favorites.add(element);
      } else {
        other.add(element);
      }
    }
    other.sort((a, b) => a.featureName.compareTo(b.featureName));
    features = [...favorites, ...other];
    indexCurrentFeature = 0;
    indexCurrentPartAnalFeature = 0;
    indexCurrentPartDevFeature = 0;
    indexCurrentPartTestFeature = 0;
    notifyListeners();
  }

  /// Ф-ция для сортировки списка фичей по времени.
  void sortListTime() {
    List<Feature> favorites = [];
    List<Feature> other = [];
    for (Feature element in features) {
      if (element.favorite == 'true') {
        favorites.add(element);
      } else {
        other.add(element);
      }
    }
    other.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    features = [...favorites, ...other];
    indexCurrentFeature = 0;
    indexCurrentPartAnalFeature = 0;
    indexCurrentPartDevFeature = 0;
    indexCurrentPartTestFeature = 0;
    notifyListeners();
  }

  /// Добавить/либо удалить признак "Избранного".
  void addFavorite() {
    (features[indexCurrentFeature!].favorite == 'false')
        ? features[indexCurrentFeature!].favorite = 'true'
        : features[indexCurrentFeature!].favorite = 'false';
    features.sort((a, b) => b.favorite.compareTo(a.favorite));
    indexCurrentFeature = 0;
    indexCurrentPartAnalFeature = 0;
    indexCurrentPartDevFeature = 0;
    indexCurrentPartTestFeature = 0;
    notifyListeners();
  }
}
