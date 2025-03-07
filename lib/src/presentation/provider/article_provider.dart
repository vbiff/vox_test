import 'package:flutter/material.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_article.dart';

class ArticleProvider extends ChangeNotifier {
  ArticleProvider({required this.getArticleUseCase});

  final GetArticle getArticleUseCase;

  List<ArticleEntity> listOfArticles = [];

  int get listLength => listOfArticles.length;

  void getArticle() async {
    listOfArticles = await getArticleUseCase();
    notifyListeners();
  }
}
