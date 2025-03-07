import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vox_test_project/src/presentation/widgets/search.dart';
import '../article_screen/view.dart';
import '../../provider/article_provider.dart';
import '../../provider/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ArticleProvider>().getArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            leading: IconButton(
              icon: Icon(
                context.watch<ThemeProvider>().isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final result = await showSearch(
                    context: context,
                    delegate: NameSearch(
                      list: value.listOfArticles.map((e) => e.title).toList(),
                    ),
                  );
                  if (result != null && context.mounted) {
                    value.filterArticles(result);
                    if (value.listOfArticles.isNotEmpty && context.mounted) {
                      final article = value.listOfArticles.firstWhere(
                        (article) => article.title == result,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ArticleScreen(
                            title: article.title,
                            description: article.body,
                          ),
                        ),
                      ).then((_) {
                        value.getArticle();
                      });
                    }
                  }
                },
              ),
            ],
          ),
          body: value.isLoading
              ? Center(child: CircularProgressIndicator())
              : value.error != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(value.error!),
                            IconButton(
                              iconSize: 48.0,
                              icon: const Icon(Icons.restart_alt),
                              onPressed: () => value.getArticle(),
                            ),
                          ],
                        ),
                      ),
                    )
                  : value.listOfArticles.isEmpty
                      ? const Center(
                          child: Text('No articles availiable'),
                        )
                      : RefreshIndicator(
                          onRefresh: () => value.getArticle(),
                          child: ListView.separated(
                            itemCount: value.listOfArticles.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ArticleScreen(
                                        title:
                                            value.listOfArticles[index].title,
                                        description:
                                            value.listOfArticles[index].body,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    value.listOfArticles[index].title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(value.listOfArticles[index]
                                              .body.length >
                                          100
                                      ? '${value.listOfArticles[index].body.substring(0, 100)}...'
                                      : value.listOfArticles[index].body),
                                ),
                              );
                            },
                          ),
                        ),
        );
      },
    );
  }
}
