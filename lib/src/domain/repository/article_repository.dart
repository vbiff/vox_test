import '../entities/article_entity.dart';

abstract interface class ArticleRepository {
  Future<List<ArticleEntity>> getArticles();
}
