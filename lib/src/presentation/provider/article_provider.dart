import 'package:flutter/material.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_article.dart';

class ArticleProvider extends ChangeNotifier {
  ArticleProvider({
    required this.getArticleUseCase,
    required this.isLoading,
    required this.error,
  });

  final GetArticle getArticleUseCase;

  List<ArticleEntity> _allArticles = [];
  List<ArticleEntity> _filteredArticles = [];
  bool isLoading;
  String? error;

  List<ArticleEntity> get listOfArticles => _filteredArticles;

  Future<void> getArticle() async {
    try {
      error = null;
      isLoading = true;
      _allArticles = await getArticleUseCase();
      _filteredArticles = _allArticles;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  void filterArticles(String result) {
    if (result.isEmpty) {
      _filteredArticles = List.from(_allArticles);
    } else {
      _filteredArticles = _allArticles
          .where((e) => e.title.toLowerCase().contains(result))
          .toList();
    }
    notifyListeners();
  }
}
