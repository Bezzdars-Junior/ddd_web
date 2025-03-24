import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String projectName;
  String favorite;

  /// Конструктор класса [Feature].
  Project({required this.projectName, required this.favorite});

  factory Project.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Project(
      projectName: data!['projectName'],
      favorite: data['favorite'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "projectName": projectName,
      "favorite": favorite,
    };
  }
}
