import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/data/datasources/article_remote_data_source.dart';
import 'src/data/repository/article_repository_impl.dart';
import 'src/domain/usecases/get_article.dart';
import 'src/presentation/pages/home_screen/view.dart';
import 'src/presentation/provider/article_provider.dart';

void main() {
  // Create the repository implementation
  final articleRepository = ArticleRepositoryImpl(
    articleRemoteDataSource: ArticleRemoteDataSource(),
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ArticleProvider(
      getArticleUseCase: GetArticle(
        articleRepository: articleRepository, // Use the created repository
      ),
    ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
