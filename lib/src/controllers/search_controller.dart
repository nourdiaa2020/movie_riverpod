import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/dio_utils/custom_dio.dart';

final searchController = StateNotifierProvider<SearchController, List<Movie>>(
    (ref) => SearchController());

class SearchController extends StateNotifier<List<Movie>> {
  SearchController() : super([]);

  final txtController = TextEditingController();

  Future<void> startSearch() async {
    final txtValue = txtController.text;
    if (txtValue.isNotEmpty) {
      final listOfMaps = (await CustomDio().send(
              reqMethod: "Get",
              path: "search/movie",
              query: {"api_key": KApiKey, "query": txtValue}))
          .data['results'] as List;
      state.clear();
      state.addAll(listOfMaps.map((e) => Movie.fromMap(e)).toList());
    } else {
      state.clear();
    }
  }
}
