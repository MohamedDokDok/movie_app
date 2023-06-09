import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/api/end_points.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/enums.dart';
import '../controller/movie_bloc/movies_bloc.dart';
import '../controller/movie_bloc/movies_events.dart';
import '../controller/movie_bloc/movies_states.dart';
import 'movie_detail_screen.dart';

class PopularMovieScreen extends StatelessWidget {
  const PopularMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appServiceLocator<MovieBloc>()..add(GetPopularMovieEvent()),
      child: BlocBuilder<MovieBloc, MoviesState>(
        builder: (context, state) {
          switch (state.popularState) {
            case RequestState.loading:
              return const SizedBox(
                height: 170.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case RequestState.loaded:
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade900,
                  title: const Center(child: Text(AppString.popular)),
                  elevation: 0.0,
                ),
                body: ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.popularMovies[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MovieDetailScreen(id: movie.id),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                width: 120.0,
                                height: 150.0,
                                fit: BoxFit.cover,
                                imageUrl:
                                    Endpoints.imageUrl(movie.backdropPath),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 120.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          movie.title,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20.0,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                (movie.voteAverage / 2)
                                                    .toStringAsFixed(1),
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                '(${movie.voteAverage})',
                                                style: const TextStyle(
                                                  fontSize: 1.0,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 50),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2.0,
                                              horizontal: 8.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[800],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Text(
                                              movie.releaseDate.split('-')[0],
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        movie.overview,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          color: Colors.white,
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.popularMovies.length),
              );
            case RequestState.error:
              return SizedBox(
                height: 170.0,
                child: Center(
                  child: Text(state.popularMessage),
                ),
              );
          }
        },
      ),
    );
  }
}
