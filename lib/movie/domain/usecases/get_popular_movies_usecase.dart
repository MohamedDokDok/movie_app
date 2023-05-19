import 'package:dartz/dartz.dart';
import 'package:movie_app_clean_architecture/core/error/failure.dart';
import 'package:movie_app_clean_architecture/core/usecases/base_usecase.dart';
import 'package:movie_app_clean_architecture/movie/domain/entities/movie.dart';
import 'package:movie_app_clean_architecture/movie/domain/repository/base_movie_repository.dart';

class GetPopularMoviesUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMovieRepository baseMovieRepository;

  GetPopularMoviesUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>>call(NoParameters parameters) async {
    return await baseMovieRepository.getPopularMovies();
  }
}
