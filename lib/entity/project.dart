import 'package:cloud_firestore/cloud_firestore.dart';

///Объект [Project], который хранит поля:
/// [projectName] - хранит имя коллекции из БД.
/// [favorite] - признак фичи, который показывает избранная фича или нет.
/// [dateTime] - время создания проекта.
/// [id] - айди проекта.
/// [viewName] - имя, которое видно на экране со списком проектов.
class Project {
  String projectName;
  String favorite;
  String dateTime;
  String id;
  String viewName;
  String dateChange;
  String description;

  /// Конструктор класса [Feature].
  Project({
    required this.projectName,
    required this.favorite,
    required this.dateTime,
    required this.id,
    required this.viewName,
    required this.dateChange,
    required this.description,
  });

  /// метод для преобразования JSON в объект [Project].
  factory Project.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Project(
      projectName: data!['projectName'],
      favorite: data['favorite'],
      dateTime: data['dataTime'],
      id: data['id'],
      viewName: data['viewName'],
      dateChange: data['dateChange'],
      description: data['description'],
    );
  }

  /// метод для преобразования объекта [Project] в JSON.
  Map<String, dynamic> toFirestore() {
    return {
      "projectName": projectName,
      "favorite": favorite,
      "dataTime": dateTime,
      "id": id,
      "viewName": viewName,
      "dateChange": dateChange,
      "description": description,
    };
  }
}
