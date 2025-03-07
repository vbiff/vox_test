import 'dart:convert';
import '../../domain/entities/article_entity.dart';
import '../../domain/repository/article_repository.dart';

import 'package:http/http.dart' as http;

import '../model/article_model.dart';

final class ArticleRemoteDataSource implements ArticleRepository {
  @override
  Future<List<ArticleEntity>> getArticles() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList =
          jsonDecode(response.body) as List<Map<String, dynamic>>;
      return jsonList.map((json) => ArticleModel.fromJson(json: json)).toList();
    } else {
      throw Exception('failed to get articles');
    }
  }
}
