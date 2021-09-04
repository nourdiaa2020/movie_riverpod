import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/controllers/search_controller.dart';
import 'package:movie_app_riverpod/src/states/search_state/search_state.dart';
import 'package:movie_app_riverpod/src/widgets/movie_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CupertinoTextField(
              placeholder: "Search",
              controller: context.read(searchController.notifier).txtController,
              padding: EdgeInsets.all(10),
              autofocus: true,
              onSubmitted: (value) {
                context.read(searchController.notifier).startSearch();
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final state = watch(searchController);
                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is SearchInitial) {
                    return GridView.builder(
                      padding: EdgeInsets.all(5),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isPortrait ? 2 : 3,
                        crossAxisSpacing: 5,
                        childAspectRatio: .7,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return MovieItem(
                          movie: state.movies[index],
                          onAddToFavorite: () {},
                        );
                      },
                      itemCount: state.movies.length,
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(state.err),
                    );
                  } else {
                    throw UnimplementedError();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
