import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:movie_app_riverpod/src/states/search_state/search_state.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/dio_utils/custom_dio.dart';

final searchController = StateNotifierProvider<SearchController, SearchState>(
    (ref) => SearchController());

class SearchController extends StateNotifier<SearchState> {
  SearchController() : super(SearchInitial([]));

  final txtController = TextEditingController();

  Future<void> startSearch() async {
    final txtValue = txtController.text;
    state = SearchLoading();
    if (txtValue.isNotEmpty) {
      final listOfMaps = (await CustomDio().send(
              reqMethod: "Get",
              path: "search/movie",
              query: {"api_key": KApiKey, "query": txtValue}))
          .data['results'] as List;
      state = SearchInitial(listOfMaps.map((e) => Movie.fromMap(e)).toList());
    } else {
      state = SearchInitial([]);
    }
  }
}
