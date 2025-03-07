import 'package:vox_test_project/src/data/datasources/article_remote_data_source.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/repository/article_repository.dart';

final class ArticleRepositoryImpl implements ArticleRepository {
  ArticleRepositoryImpl({required this.articleRemoteDataSource});

  final ArticleRemoteDataSource articleRemoteDataSource;

  @override
  Future<List<ArticleEntity>> getArticles() async {
    try {
      List<ArticleEntity> listOfArticles =
          await articleRemoteDataSource.getArticles();
      return listOfArticles;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
