import 'package:vox_test_project/src/domain/entities/article_entity.dart';

import '../repository/article_repository.dart';

final class GetArticle {
  const GetArticle({required this.articleRepository});

  final ArticleRepository articleRepository;

  Future<List<ArticleEntity>> call() async {
    return await articleRepository.getArticles();
  }
}
