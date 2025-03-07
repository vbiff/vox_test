import 'package:flutter/material.dart';

class NameSearch extends SearchDelegate<String> {
  NameSearch({
    required this.list,
  });

  final List<String> list;
  late String result;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query.isEmpty ? '' : query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = list.where(
      (e) => e.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );
    return Scaffold(
      body: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              suggestions.elementAt(index),
            ),
            onTap: () {
              result = suggestions.elementAt(index);
              close(context, result);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          close(context, query);
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = list.where(
      (e) => e.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              suggestions.elementAt(index),
            ),
            onTap: () {
              query = suggestions.elementAt(index);
              result = query;
              close(context, result);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          close(context, query);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
