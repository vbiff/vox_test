import 'package:flutter/material.dart';
import 'package:vox_test_project/src/data/model/example.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: ListView.separated(
          itemCount: Example.example.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return InkWell(
              child: ListTile(
                title: Text(Example.example[index]['title'].toString()),
                subtitle: Text(Example.example[index]['body']
                            .toString()
                            .length >
                        100
                    ? '${Example.example[index]['body'].toString().substring(0, 100)}...'
                    : Example.example[index]['body'].toString()),
              ),
            );
          }),
    );
  }
}
