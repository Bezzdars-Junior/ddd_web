import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  final List<Feature> features = [];

  Future<String> initFeature() async {
    if (firstInitial) {
      final db = FirebaseFirestore.instance;

      await db.collection('features').get().then((docs) {
        countFeaturesDataBase = docs.docs.length;
      });
      for (int i = 0; i < countFeaturesDataBase; i++) {
        final ref = db.collection('features').doc('$i').withConverter(
            fromFirestore: Feature.fromFirestore,
            toFirestore: (Feature feature, _) => feature.toFirestore());
        final docSnap = await ref.get();
        final feature = docSnap.data();
        if (feature != null) {
          features.add(feature);
        }
      }

      firstInitial = false;

      return 'Data Loaded';
    }
    return 'Second initial';
  }

  void saveDataBase() async {
    final db = FirebaseFirestore.instance;
    if (countFeaturesDataBase > features.length) {
      for (int i = features.length; i <= countFeaturesDataBase; i++) {
        db.collection('features').doc('$i').delete();
      }
    }
    for (int i = 0; i < features.length; i++) {
      final docRef = db
          .collection('features')
          .withConverter(
            fromFirestore: Feature.fromFirestore,
            toFirestore: (Feature feature, _) => feature.toFirestore(),
          )
          .doc('$i');
      await docRef.set(features[i]);
    }
  }

  void changeFeature(int index) {
    indexCurrentFeature = index;
    indexCurrentPartAnalFeature = 0;
    setState(() {});
  }

  void changeFlex(String nameColumn) {
    if (nameColumn == 'anal') {
      flexAnal == 1 ? flexAnal = 20 : flexAnal = 1;
      setState(() {});
    }
    if (nameColumn == 'dev') {
      flexDev == 1 ? flexDev = 20 : flexDev = 1;
      setState(() {});
    }
    if (nameColumn == 'test') {
      flexTest == 1 ? flexTest = 20 : flexTest = 1;
      setState(() {});
    }
  }

  addFeature(context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Center(
            child: Text('Создание новой фичи'),
          ),
          content: Container(
            height: 300,
            width: 300,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Введите название новой фичи'),
                TextField(controller: controllerNameForNewFeature),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: saveNewFeature, child: Text('Save')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'))
          ],
        ),
      );

  void deleteCurrentFeature() {
    features.removeAt(indexCurrentFeature!);
    indexCurrentFeature = 0;
    setState(() {});
  }

  void saveNewFeature() {
    features.add(Feature(
        anal: [''],
        dev: [''],
        test: [''],
        featureName: controllerNameForNewFeature.text));
    Navigator.of(context).pop();
    setState(() {});
  }

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
    setState(() {});
  }

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
    setState(() {});
  }

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
    setState(() {});
  }

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
    setState(() {});
  }

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
    setState(() {});
  }

  void editingNameFeature() {
    readNameFeature = false;
    setState(() {});
  }

  void saveEditedNameFeature() {
    features[indexCurrentFeature!].featureName = controllerFeatureName.text;
    readNameFeature = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String nameFeature = (indexCurrentFeature == null)
        ? 'Выбери фичу'
        : features[indexCurrentFeature!].featureName;
    controllerFeatureName.text = nameFeature;
    return FutureBuilder(
        future: initFeature(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                children: [
                  /// Колонка слева с фичами
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: readNameFeature
                                    ? Text(
                                        maxLines: 2,
                                        nameFeature,
                                        style: TextStyle(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: TextField(
                                                  controller:
                                                      controllerFeatureName)),
                                          IconButton(
                                              onPressed: saveEditedNameFeature,
                                              icon: Icon(Icons.check)),
                                        ],
                                      ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 14,
                            child: ListView.builder(
                              itemCount: features.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    onPressed: () {
                                      changeFeature(index);
                                    },
                                    child: Text(features[index].featureName));
                              },
                            )),
                        TextButton(
                            onPressed: saveDataBase,
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromARGB(255, 172, 37, 160))),
                            child: const Center(
                                child: Text(
                              'Сохранить изменения',
                              maxLines: 2,
                              style: TextStyle(color: Colors.white),
                            ))),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: (indexCurrentFeature == null)
                                  ? null
                                  : () => addFeature(context),
                              icon: Icon(Icons.add_box),
                            ),
                            IconButton(
                              onPressed: (indexCurrentFeature == null)
                                  ? null
                                  : deleteCurrentFeature,
                              icon: Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: (indexCurrentFeature == null)
                                  ? null
                                  : editingNameFeature,
                              icon: Icon(Icons.create),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    width: 1,
                    height: double.infinity,
                  ),

                  /// Колонка справа с таблицей
                  Expanded(
                    flex: 14,
                    child: Row(
                      children: [
                        Expanded(
                          flex: flexAnal,
                          child: Column(
                            children: [
                              (flexDev == 20 && flexTest == 20) ||
                                      (flexDev == 20 &&
                                          flexTest == 1 &&
                                          flexAnal == 1) ||
                                      (flexDev == 1 &&
                                          flexTest == 20 &&
                                          flexAnal == 1)
                                  ? IconButton(
                                      onPressed: () => changeFlex('anal'),
                                      icon: Icon(Icons.analytics))
                                  : TextButton(
                                      child: Text(
                                        'Аналитика',
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20),
                                      ),
                                      onPressed: () => changeFlex('anal')),
                              Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              (flexDev == 20 && flexTest == 20) ||
                                      (flexDev == 20 &&
                                          flexTest == 1 &&
                                          flexAnal == 1) ||
                                      (flexDev == 1 &&
                                          flexTest == 20 &&
                                          flexAnal == 1)
                                  ? Text('')
                                  : readAnal
                                      ? Expanded(
                                          flex: 15,
                                          child: ListView(
                                            children: [
                                              Center(
                                                child: MarkdownBody(
                                                  data: (indexCurrentFeature ==
                                                          null)
                                                      ? 'Выбери фичу'
                                                      : features[indexCurrentFeature!]
                                                              .anal[
                                                          indexCurrentPartAnalFeature],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            TextField(
                                              controller: controllerAnal,
                                              maxLines: 33,
                                            ),
                                            IconButton(
                                                onPressed: () =>
                                                    saveEditedColumn('anal'),
                                                icon: Icon(Icons.save))
                                          ],
                                        ),
                              (flexDev == 20 && flexTest == 20) ||
                                      (flexDev == 20 &&
                                          flexTest == 1 &&
                                          flexAnal == 1) ||
                                      (flexDev == 1 &&
                                          flexTest == 20 &&
                                          flexAnal == 1) ||
                                      indexCurrentFeature == null
                                  ? Text('')
                                  : Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: (indexCurrentFeature ==
                                                      null)
                                                  ? 1
                                                  : features[
                                                          indexCurrentFeature!]
                                                      .anal
                                                      .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            (index ==
                                                                    indexCurrentPartAnalFeature)
                                                                ? Colors.grey
                                                                : Colors.white),
                                                  ),
                                                  onPressed: () =>
                                                      changePartFeature(
                                                          index, 'anal'),
                                                  child: Text(
                                                    '${index + 1}',
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () =>
                                                  addPartFeature('anal'),
                                              icon: Icon(Icons.plus_one)),
                                          IconButton(
                                              onPressed: () =>
                                                  deletePartFeature('anal'),
                                              icon: Icon(Icons.delete)),
                                          IconButton(
                                              onPressed: () =>
                                                  editingColumn('anal'),
                                              icon: Icon(Icons.create)),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: 1,
                          height: double.infinity,
                        ),

                        /// Колонка разработки
                        Expanded(
                          flex: flexDev,
                          child: Column(
                            children: [
                              (flexAnal == 20 && flexTest == 20) ||
                                      (flexAnal == 20 &&
                                          flexTest == 1 &&
                                          flexDev == 1) ||
                                      (flexAnal == 1 &&
                                          flexTest == 20 &&
                                          flexDev == 1)
                                  ? IconButton(
                                      onPressed: () => changeFlex('dev'),
                                      icon: Icon(Icons.developer_board))
                                  : TextButton(
                                      child: Text(
                                        'Разработка',
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20),
                                      ),
                                      onPressed: () => changeFlex('dev')),
                              Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              (flexAnal == 20 && flexTest == 20) ||
                                      (flexAnal == 20 &&
                                          flexTest == 1 &&
                                          flexDev == 1) ||
                                      (flexAnal == 1 &&
                                          flexTest == 20 &&
                                          flexDev == 1)
                                  ? Text('')
                                  : readDev
                                      ? Expanded(
                                          flex: 15,
                                          child: ListView(
                                            children: [
                                              Center(
                                                child: Text(indexCurrentFeature ==
                                                        null
                                                    ? 'Выбери фичу'
                                                    : features[indexCurrentFeature!]
                                                            .dev[
                                                        indexCurrentPartDevFeature]),
                                              )
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            TextField(
                                              controller: controllerDev,
                                              maxLines: 35,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  saveEditedColumn('dev');
                                                },
                                                icon: Icon(Icons.save))
                                          ],
                                        ),
                              (flexAnal == 20 && flexTest == 20) ||
                                      (flexAnal == 20 &&
                                          flexTest == 1 &&
                                          flexDev == 1) ||
                                      (flexAnal == 1 &&
                                          flexTest == 20 &&
                                          flexDev == 1) ||
                                      indexCurrentFeature == null
                                  ? Text('')
                                  : Expanded(
                                      child: Row(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (indexCurrentFeature ==
                                                    null)
                                                ? 1
                                                : features[indexCurrentFeature!]
                                                    .dev
                                                    .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            (index ==
                                                                    indexCurrentPartDevFeature)
                                                                ? Colors.grey
                                                                : Colors.white),
                                                  ),
                                                  onPressed: () =>
                                                      changePartFeature(
                                                          index, 'dev'),
                                                  child: Text('${index + 1}'));
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () =>
                                                addPartFeature('anal'),
                                            icon: Icon(Icons.plus_one)),
                                        IconButton(
                                            onPressed: () =>
                                                deletePartFeature('dev'),
                                            icon: Icon(Icons.delete)),
                                        IconButton(
                                            onPressed: () =>
                                                editingColumn('dev'),
                                            icon: Icon(Icons.create)),
                                      ],
                                    ))
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: 1,
                          height: double.infinity,
                        ),
                        Expanded(
                          flex: flexTest,
                          child: Column(
                            children: [
                              (flexAnal == 20 && flexDev == 20) ||
                                      (flexAnal == 20 &&
                                          flexDev == 1 &&
                                          flexTest == 1) ||
                                      (flexAnal == 1 &&
                                          flexDev == 20 &&
                                          flexTest == 1)
                                  ? IconButton(
                                      onPressed: () => changeFlex('test'),
                                      icon: Icon(Icons.article))
                                  : TextButton(
                                      child: Text(
                                        'Тестирование',
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20),
                                      ),
                                      onPressed: () => changeFlex('test')),
                              Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              (flexAnal == 20 && flexDev == 20) ||
                                      (flexAnal == 20 &&
                                          flexDev == 1 &&
                                          flexTest == 1) ||
                                      (flexAnal == 1 &&
                                          flexDev == 20 &&
                                          flexTest == 1)
                                  ? const Text('')
                                  : readTest
                                      ? Expanded(
                                          flex: 15,
                                          child: ListView(
                                            children: [
                                              Center(
                                                child: Text(indexCurrentFeature ==
                                                        null
                                                    ? 'Выбери фичу'
                                                    : features[indexCurrentFeature!]
                                                            .test[
                                                        indexCurrentPartTestFeature]),
                                              )
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            TextField(
                                              controller: controllerTest,
                                              maxLines: 35,
                                            ),
                                            IconButton(
                                                onPressed: () =>
                                                    saveEditedColumn('test'),
                                                icon: Icon(Icons.save)),
                                          ],
                                        ),
                              (flexAnal == 20 && flexDev == 20) ||
                                      (flexAnal == 20 &&
                                          flexDev == 1 &&
                                          flexTest == 1) ||
                                      (flexAnal == 1 &&
                                          flexDev == 20 &&
                                          flexTest == 1) ||
                                      indexCurrentFeature == null
                                  ? Text('')
                                  : Expanded(
                                      child: Row(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (indexCurrentFeature ==
                                                    null)
                                                ? 1
                                                : features[indexCurrentFeature!]
                                                    .test
                                                    .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            (index ==
                                                                    indexCurrentPartTestFeature)
                                                                ? Colors.grey
                                                                : Colors.white),
                                                  ),
                                                  onPressed: () =>
                                                      changePartFeature(
                                                          index, 'test'),
                                                  child: Text('${index + 1}'));
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () =>
                                                addPartFeature('test'),
                                            icon: Icon(Icons.plus_one)),
                                        IconButton(
                                            onPressed: () =>
                                                deletePartFeature('test'),
                                            icon: Icon(Icons.delete)),
                                        IconButton(
                                            onPressed: () =>
                                                editingColumn('test'),
                                            icon: Icon(Icons.create)),
                                      ],
                                    ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}

class Feature {
  final List<String> anal;
  final List<String> dev;
  final List<String> test;
  String featureName;

  Feature({
    required this.anal,
    required this.dev,
    required this.test,
    required this.featureName,
  });

  factory Feature.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Feature(
      featureName: data!['featureName'],
      anal: List.from(data['anal']),
      dev: List.from(data['dev']),
      test: List.from(data['test']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "anal": anal,
      "dev": dev,
      "test": test,
      "featureName": featureName,
    };
  }
}
