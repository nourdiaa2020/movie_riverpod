import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/controllers/movie_pagination_controller.dart';
import 'package:movie_app_riverpod/src/widgets/movie_item.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController = watch(
      moviePaginationControllerProvider.notifier,
    );

    final paginationState = watch(moviePaginationControllerProvider);

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Builder(
      builder: (context) {
        if (paginationState.refreshError) {
          return _ErrorBody(message: paginationState.errorMessage);
        } else if (paginationState.movies.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: EdgeInsets.all(5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait ? 2 : 3,
            crossAxisSpacing: 5,
            childAspectRatio: .7,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            // use the index for pagination
            paginationController.handleScrollWithIndex(index);
            return MovieItem(
              movie: paginationState.movies[index],
              onAddToFavorite: () {
                /// todo we need to refresh the list
                context
                    .refresh(moviePaginationControllerProvider)
                    .refreshMovies(paginationState.movies[index].id);
              },
            );
          },
          itemCount: paginationState.movies.length,
        );
      },
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            ElevatedButton(
              onPressed: () => context
                  .refresh(moviePaginationControllerProvider)
                  .getMovies(),
              child: Text("Try again"),
            ),
          ],
        ),
      ),
    );
  }
}
