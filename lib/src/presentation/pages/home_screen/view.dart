import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../article_screen/view.dart';
import '../../provider/article_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<ArticleProvider>(context, listen: false).getArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Consumer<ArticleProvider>(
        builder: (context, value, child) {
          if (value.listOfArticles.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: value.listOfArticles.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ArticleScreen(
                        title: value.listOfArticles[index].title,
                        description: value.listOfArticles[index].body,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    value.listOfArticles[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(value.listOfArticles[index].body.length > 100
                      ? '${value.listOfArticles[index].body.substring(0, 100)}...'
                      : value.listOfArticles[index].body),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
