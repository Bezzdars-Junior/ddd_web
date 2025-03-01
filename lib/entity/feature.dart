import 'package:cloud_firestore/cloud_firestore.dart';

/// Объект [Feature], который хранит поля.
/// [anal] - массив частей аналитиики.
/// [dev] - массив частей разработки.
/// [test] - массив частей тестирования.
/// [featureName] - название фичи.
/// [dateTime] - время создания фичи.
/// [favorite] - признак фичи, который показывает избранная фича или нет.
class Feature {
  final List<String> anal;
  final List<String> dev;
  final List<String> test;
  String featureName;
  String dateTime;
  String favorite;

  /// Конструктор класса [Feature].
  Feature(
      {required this.anal,
      required this.dev,
      required this.test,
      required this.featureName,
      required this.dateTime,
      required this.favorite});

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
      favorite: data['favorite'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "anal": anal,
      "dev": dev,
      "test": test,
      "featureName": featureName,
      "dateTime": dateTime,
      "favorite": favorite,
    };
  }
}
