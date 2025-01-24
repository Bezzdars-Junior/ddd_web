import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

var featch1 = Featch(anal: [
  '''
# DDD

## Инструкция запуска приложения

### Инструкция запуска через терминал

1. Скачиваем зависимости проекта: `flutter pub get`
2. Просмотреть доступные девайсы : `flutter devices`
3. Запустить мобильное приложение (Пример web платформа):`flutter run -d chrome`
    ''',
  'какая хуйня на второй'
], dev: [
  'Info Dev_1',
  'разработка 2'
], test: [
  'Info Test_1',
  'тестирование 2'
], name: '1');
var featch2 = Featch(
    anal: ['Info Anal_2'],
    dev: ['Info Dev_2'],
    test: ['Info Test_2'],
    name: '2');
var featch3 = Featch(
    anal: ['Info Anal_3'],
    dev: ['Info Dev_3'],
    test: ['Info Test_3'],
    name: '3');
var featch4 = Featch(
    anal: ['Info Anal_4'],
    dev: ['Info Dev_4'],
    test: ['Info Test_4'],
    name: '4');
List<Featch> listFeatch = [featch1, featch2, featch3, featch4];

class _MainScreenState extends State<MainScreen> {
  int flexAnal = 1;
  int flexDev = 1;
  int flexTest = 1;
  int indexFeatch = 0;
  int indexPartFeatchAnal = 0;
  int indexPartFeatchDev = 0;
  int indexPartFeatchTest = 0;
  String nameFeatch = 'Выбери фичу';
  bool readTest = true;
  bool readDev = true;
  bool readAnal = true;
  bool readNameFeatch = true;

  void changeFeatch(int index) {
    indexPartFeatchAnal = indexPartFeatchDev = indexPartFeatchTest = 0;
    indexFeatch = index;
    nameFeatch = '${listFeatch[index].name}';
    setState(() {});
  }

  void changeFlexAnal() {
    if (flexAnal == 1) {
      flexAnal = 20;
      setState(() {});
    } else {
      flexAnal = 1;
      setState(() {});
    }
  }

  void changeFlexDev() {
    if (flexDev == 1) {
      flexDev = 20;
      setState(() {});
    } else {
      flexDev = 1;
      setState(() {});
    }
  }

  void changeFlexTest() {
    if (flexTest == 1) {
      flexTest = 20;
      setState(() {});
    } else {
      flexTest = 1;
      setState(() {});
    }
  }

  void deleteCurrentFeatch(int currentFeatch) {
    listFeatch.removeAt(currentFeatch);
    if (currentFeatch == listFeatch.length) {
      indexFeatch = 0;
    }
    nameFeatch = 'Featch #${indexFeatch + 1}';
    setState(() {});
  }

  final controllerName = TextEditingController();
  final controllerTestUpdate = TextEditingController();
  final controllerDevUpdate = TextEditingController();
  final controllerAnalUpdate = TextEditingController();
  final controllerNameFeatchUpdate = TextEditingController();

  void saveFeatch() {
    var textName = controllerName.text;
    var featch = Featch(anal: [''], dev: [''], test: [''], name: textName);
    listFeatch.add(featch);
    setState(() {});

    controllerName.text = '';
    Navigator.of(context).pop();
  }

  alert(context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Center(
            child: Text('Create new featch'),
          ),
          content: Column(
            children: [
              SizedBox(height: 20),
              Text('Name featch'),
              TextField(controller: controllerName),
            ],
          ),
          actions: [
            TextButton(onPressed: saveFeatch, child: Text('Save')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'))
          ],
        ),
      );

  void replaceFlexAll() {
    flexAnal = flexDev = flexTest = 1;
    setState(() {});
  }

  void updateInfoTest() {
    controllerTestUpdate.text =
        '${listFeatch[indexFeatch].test[indexPartFeatchTest]}';
    readTest = false;
    setState(() {});
  }

  void updateInfoDev() {
    controllerDevUpdate.text =
        '${listFeatch[indexFeatch].dev[indexPartFeatchDev]}';
    readDev = false;
    setState(() {});
  }

  void updateInfoAnal() {
    controllerAnalUpdate.text =
        '${listFeatch[indexFeatch].anal[indexPartFeatchAnal]}';
    readAnal = false;
    setState(() {});
  }

  void saveInfoTest() {
    String text = controllerTestUpdate.text;
    listFeatch[indexFeatch].test[indexPartFeatchTest] = text;
    readTest = true;
    setState(() {});
  }

  void saveInfoDev() {
    String text = controllerDevUpdate.text;
    listFeatch[indexFeatch].dev[indexPartFeatchDev] = text;
    readDev = true;
    setState(() {});
  }

  void saveInfoAnal() {
    String text = controllerAnalUpdate.text;
    listFeatch[indexFeatch].anal[indexPartFeatchAnal] = text;
    readAnal = true;
    setState(() {});
  }

  updateCurrentFeatch(index) {
    controllerNameFeatchUpdate.text = '${listFeatch[index].name}';
    readNameFeatch = false;
    setState(() {});
  }

  saveNameFeatch(index) {
    listFeatch[index].name = controllerNameFeatchUpdate.text;
    controllerNameFeatchUpdate.text = '';
    readNameFeatch = true;
    setState(() {});
  }

  cancelUpdateNameFeatch() {
    controllerNameFeatchUpdate.text = '';
    readNameFeatch = true;
    setState(() {});
  }

  changePartAnal(index) {
    indexPartFeatchAnal = index;
    setState(() {});
  }

  addPartFeatchAnal() {
    listFeatch[indexFeatch].anal.add('');
    indexPartFeatchAnal = listFeatch[indexFeatch].anal.length - 1;
    setState(() {});
  }

  deletePartFeatchAnal() {
    listFeatch[indexFeatch].anal.removeAt(indexPartFeatchAnal);
    indexPartFeatchAnal = indexPartFeatchAnal - 1;
    setState(() {});
  }

  changePartDev(index) {
    indexPartFeatchDev = index;
    setState(() {});
  }

  addPartFeatchDev() {
    listFeatch[indexFeatch].dev.add('');
    indexPartFeatchDev = listFeatch[indexFeatch].dev.length - 1;
    setState(() {});
  }

  deletePartFeatchDev() {
    listFeatch[indexFeatch].dev.removeAt(indexPartFeatchDev);
    indexPartFeatchDev = indexPartFeatchDev - 1;
    setState(() {});
  }

  changePartTest(index) {
    indexPartFeatchTest = index;
    setState(() {});
  }

  addPartFeatchTest() {
    listFeatch[indexFeatch].test.add('');
    indexPartFeatchTest = listFeatch[indexFeatch].test.length - 1;
    setState(() {});
  }

  deletePartFeatchTest() {
    listFeatch[indexFeatch].test.removeAt(indexPartFeatchTest);
    indexPartFeatchTest = indexPartFeatchTest - 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          IconButton(onPressed: replaceFlexAll, icon: Icon(Icons.replay)),
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
                        child: readNameFeatch
                            ? Text(
                                maxLines: 2,
                                listFeatch[indexFeatch].name,
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
                                              controllerNameFeatchUpdate)),
                                  IconButton(
                                      onPressed: () {
                                        saveNameFeatch(indexFeatch);
                                      },
                                      icon: Icon(Icons.check)),
                                  IconButton(
                                      onPressed: () {
                                        cancelUpdateNameFeatch();
                                      },
                                      icon: Icon(Icons.clear)),
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
                    itemCount: listFeatch.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                          onPressed: () {
                            changeFeatch(index);
                          },
                          child: Text('${listFeatch[index].name}'));
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        alert(context);
                      },
                      icon: Icon(Icons.add_box),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteCurrentFeatch(indexFeatch);
                      },
                      icon: Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        updateCurrentFeatch(indexFeatch);
                      },
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
                              (flexDev == 1 && flexTest == 20 && flexAnal == 1)
                          ? IconButton(
                              onPressed: changeFlexAnal,
                              icon: Icon(Icons.analytics))
                          : TextButton(
                              child: Text(
                                'Anal',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 20),
                              ),
                              onPressed: changeFlexAnal),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      (flexDev == 20 && flexTest == 20) ||
                              (flexDev == 20 &&
                                  flexTest == 1 &&
                                  flexAnal == 1) ||
                              (flexDev == 1 && flexTest == 20 && flexAnal == 1)
                          ? Text('')
                          : readAnal
                              ? Expanded(
                                  flex: 15,
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: MarkdownBody(
                                            data:
                                                '${listFeatch[indexFeatch].anal[indexPartFeatchAnal]}'),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    TextField(
                                      controller: controllerAnalUpdate,
                                      maxLines: 33,
                                    ),
                                    IconButton(
                                        onPressed: saveInfoAnal,
                                        icon: Icon(Icons.save))
                                  ],
                                ),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listFeatch[indexFeatch].anal.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    onPressed: () {
                                      changePartAnal(index);
                                    },
                                    child: Text('${index + 1}'));
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: addPartFeatchAnal,
                              icon: Icon(Icons.plus_one)),
                          IconButton(
                              onPressed: deletePartFeatchAnal,
                              icon: Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                updateInfoAnal();
                              },
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
                  flex: flexDev,
                  child: Column(
                    children: [
                      (flexAnal == 20 && flexTest == 20) ||
                              (flexAnal == 20 &&
                                  flexTest == 1 &&
                                  flexDev == 1) ||
                              (flexAnal == 1 && flexTest == 20 && flexDev == 1)
                          ? IconButton(
                              onPressed: changeFlexDev,
                              icon: Icon(Icons.developer_board))
                          : TextButton(
                              child: Text(
                                'Dev',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 20),
                              ),
                              onPressed: changeFlexDev),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      (flexAnal == 20 && flexTest == 20) ||
                              (flexAnal == 20 &&
                                  flexTest == 1 &&
                                  flexDev == 1) ||
                              (flexAnal == 1 && flexTest == 20 && flexDev == 1)
                          ? Text('')
                          : readDev
                              ? Expanded(
                                  flex: 15,
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: Text(
                                            '${listFeatch[indexFeatch].dev[indexPartFeatchDev]}'),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    TextField(
                                      controller: controllerDevUpdate,
                                      maxLines: 35,
                                    ),
                                    IconButton(
                                        onPressed: saveInfoDev,
                                        icon: Icon(Icons.save))
                                  ],
                                ),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listFeatch[indexFeatch].dev.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    onPressed: () {
                                      changePartDev(index);
                                    },
                                    child: Text('${index + 1}'));
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: addPartFeatchDev,
                              icon: Icon(Icons.plus_one)),
                          IconButton(
                              onPressed: deletePartFeatchDev,
                              icon: Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                updateInfoDev();
                              },
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
                              (flexAnal == 1 && flexDev == 20 && flexTest == 1)
                          ? IconButton(
                              onPressed: changeFlexTest,
                              icon: Icon(Icons.article))
                          : TextButton(
                              child: Text(
                                'Test',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 20),
                              ),
                              onPressed: changeFlexTest),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      (flexAnal == 20 && flexDev == 20) ||
                              (flexAnal == 20 &&
                                  flexDev == 1 &&
                                  flexTest == 1) ||
                              (flexAnal == 1 && flexDev == 20 && flexTest == 1)
                          ? const Text('')
                          : readTest
                              ? Expanded(
                                  flex: 15,
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: Text(
                                            '${listFeatch[indexFeatch].test[indexPartFeatchTest]}'),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    TextField(
                                      controller: controllerTestUpdate,
                                      maxLines: 35,
                                    ),
                                    IconButton(
                                        onPressed: saveInfoTest,
                                        icon: Icon(Icons.save)),
                                  ],
                                ),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listFeatch[indexFeatch].test.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    onPressed: () {
                                      changePartTest(index);
                                    },
                                    child: Text('${index + 1}'));
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: addPartFeatchTest,
                              icon: Icon(Icons.plus_one)),
                          IconButton(
                              onPressed: deletePartFeatchTest,
                              icon: Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                updateInfoTest();
                              },
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
}

class Featch {
  late List<String> anal;
  late List<String> dev;
  late List<String> test;
  late String name;

  Featch({
    required this.anal,
    required this.dev,
    required this.test,
    required this.name,
  });
}
