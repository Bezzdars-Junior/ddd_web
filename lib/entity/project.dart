import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String projectName;
  String favorite;
  String dataTime;
  String id;

  /// Конструктор класса [Feature].
  Project(
      {required this.projectName,
      required this.favorite,
      required this.dataTime,
      required this.id});

  factory Project.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Project(
      projectName: data!['projectName'],
      favorite: data['favorite'],
      dataTime: data['dataTime'],
      id: data['id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "projectName": projectName,
      "favorite": favorite,
      "dataTime": dataTime,
      "id": id,
    };
  }
}
