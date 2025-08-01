import 'package:http/http.dart' as http;

import '../screens/main_screen/export_widgets.dart';

class ApiClient {
  final _uri = 'http://localhost:8080/main_page';
  final _headers = {'Content-Type': 'application/json'};

  Future<List<Project>> getProjects([String? path]) async {
    final url = _createUrl(path);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = await jsonDecode(response.body) as List<dynamic>;
        final projectsFromBD = json.map((e) => Project.fromJson(e)).toList();
        return projectsFromBD;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<Project> postProject(Map<String, Object> body, [String? path]) async {
    final url = _createUrl(path);
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final json = await jsonDecode(response.body) as Map<String, dynamic>;
        final project = Project.fromJson(json);
        return project;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<Project> putProject(
    String? path,
    Map<String, dynamic> body,
  ) async {
    final url = _createUrl(path);
    try {
      final response = await http.put(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final json = await jsonDecode(response.body) as Map<String, dynamic>;
        final project = Project.fromJson(json);
        return project;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteProject(String path) async {
    final url = _createUrl(path);
    try {
      final response = await http.delete(
        url,
        headers: _headers,
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Uri _createUrl(String? path) {
    late final url;
    if (path != null) {
      url = Uri.parse(_uri + path);
    } else {
      url = Uri.parse(_uri);
    }
    return url;
  }
}
