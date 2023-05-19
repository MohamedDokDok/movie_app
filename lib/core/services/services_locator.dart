import 'package:get_it/get_it.dart';

import '../../movie/data/datasource/movie_remote_data_source.dart';
import '../../movie/data/repository/movies_repository.dart';
import '../../movie/domain/repository/base_movie_repository.dart';
import '../../movie/domain/usecases/get_movie_details_usecase.dart';
import '../../movie/domain/usecases/get_now_playing_movies_usecase.dart';
import '../../movie/domain/usecases/get_popular_movies_usecase.dart';
import '../../movie/domain/usecases/get_recommendation_usecase.dart';
import '../../movie/domain/usecases/get_top_rated_movies_usecase.dart';
import '../../movie/presentation/controller/movie_bloc/movies_bloc.dart';
import '../../movie/presentation/controller/movie_details_bloc/movie_details_bloc.dart';

final appServiceLocator = GetIt.instance;

class ServicesLocator {
  void init() {
    //BLoc
    appServiceLocator.registerFactory(() => MovieBloc(appServiceLocator(), appServiceLocator(), appServiceLocator()));
    appServiceLocator.registerFactory(() => MovieDetailsBloc(appServiceLocator(), appServiceLocator()));

    // REPOSITORY
    appServiceLocator.registerLazySingleton<BaseMovieRepository>(() => MovieRepository(appServiceLocator()));

    ///DATA SOURCE
    appServiceLocator.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());

    ///USE CASES
    appServiceLocator.registerLazySingleton(() => GetNowPlayingMoviesUseCase(appServiceLocator()));
    appServiceLocator.registerLazySingleton(() => GetPopularMoviesUseCase(appServiceLocator()));
    appServiceLocator.registerLazySingleton(() => GetTopRatedMoviesUseCase(appServiceLocator()));
    appServiceLocator.registerLazySingleton(() => GetMovieDetailsUseCase(appServiceLocator()));
    appServiceLocator.registerLazySingleton(() => GetRecommendationUseCase(appServiceLocator()));

  }
}
