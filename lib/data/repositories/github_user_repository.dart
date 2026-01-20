import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/github_user.dart';
import '../../core/config/constants.dart';

class GithubApiService {
  final token = dotenv.env['GITHUB_TOKEN'];

  Future<List<GithubUser>> fetchUsers(int since) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/users?since=$since&per_page=20'),
      headers: {
        'Accept': 'application/vnd.github+json',
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      print('STATUS CODE: ${response.statusCode}');
      print('BODY: ${response.body}');
      return data.map((e) => GithubUser.fromJson(e)).toList();
    } else {
      throw Exception(
        'Failed to load users: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<GithubUser> fetchUserDetail(String username) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/users/$username'),
      headers: {
        'Accept': 'application/vnd.github+json',
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GithubUser.fromJson(data);
    } else {
      throw Exception('Failed to load user detail');
    }
  }
}
