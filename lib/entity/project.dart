import 'package:json_annotation/json_annotation.dart';

///Объект [Project], который хранит поля:
/// [projectName] - хранит имя коллекции из БД.
/// [favorite] - признак фичи, который показывает избранная фича или нет.
/// [dateTime] - время создания проекта.
/// [id] - айди проекта.
/// [viewName] - имя, которое видно на экране со списком проектов.

part 'project.g.dart';

@JsonSerializable()
class Project {
  String projectName;
  bool favourite;
  String dateTime;
  int id;
  String dateChange;
  String description;

  Project({
    required this.projectName,
    required this.favourite,
    required this.dateTime,
    required this.id,
    required this.dateChange,
    required this.description,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
