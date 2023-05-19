
import 'package:flutter/material.dart';

import '../../movie/presentation/screens/movies_screen.dart';
import '../core/utils/app_string.dart';


class MovieApp extends StatelessWidget {
  // named constructor
  const MovieApp._internal();

  // singleton or single instance
  static const MovieApp _instance = MovieApp._internal();

  //factory
  factory MovieApp() => _instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.movieTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: const MoviesScreen(),
    );
  }
}
