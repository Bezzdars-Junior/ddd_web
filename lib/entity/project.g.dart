// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
  projectName: json['projectName'] as String,
  favourite: json['favourite'] as bool,
  dateTime: json['dateTime'] as String,
  id: (json['id'] as num).toInt(),
  dateChange: json['dateChange'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
  'projectName': instance.projectName,
  'favourite': instance.favourite,
  'dateTime': instance.dateTime,
  'id': instance.id,
  'dateChange': instance.dateChange,
  'description': instance.description,
};
