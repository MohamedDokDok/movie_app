import 'package:movie_app_clean_architecture/movie/domain/entities/genres.dart';

class GenresModel extends Genres {
  const GenresModel({
    required super.id,
    required super.name,
  });
  factory GenresModel.fromJson(Map<String, dynamic> json) =>
      GenresModel(
        id: json['id'],
        name: json['name'],
      );
}
