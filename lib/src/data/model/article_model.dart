import '../../domain/entities/article_entity.dart';

final class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.body,
  });

  factory ArticleModel.fromJson({required Map<String, dynamic> json}) {
    return switch (json) {
      {'id': int id, 'title': String title, 'body': String body} =>
        ArticleModel(
          id: id.toString(),
          title: title,
          body: body,
        ),
      _ => throw const FormatException('failed to get article')
    };
  }
}
