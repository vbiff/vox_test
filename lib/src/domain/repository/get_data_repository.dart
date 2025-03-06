import '../entities/article.dart';

abstract interface class GetDataRepository {
  Future<List<Article>> getArticles();
}
