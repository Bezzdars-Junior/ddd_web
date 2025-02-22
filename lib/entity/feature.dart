import 'package:cloud_firestore/cloud_firestore.dart';

class Feature {
  final List<String> anal;
  final List<String> dev;
  final List<String> test;
  String featureName;
  String dateTime;

  Feature({
    required this.anal,
    required this.dev,
    required this.test,
    required this.featureName,
    required this.dateTime,
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
      dateTime: data['dateTime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "anal": anal,
      "dev": dev,
      "test": test,
      "featureName": featureName,
      "dateTime": dateTime,
    };
  }
}
