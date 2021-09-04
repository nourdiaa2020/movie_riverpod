import 'package:flutter/material.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:movie_app_riverpod/src/utils/data_storage.dart';
import 'package:movie_app_riverpod/src/widgets/movie_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({Key? key}) : super(key: key);

  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late List<Movie> list;

  @override
  void initState() {
    super.initState();
    list = DataStorage.allFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

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
          movie: list[index],
          isFromFav: true,
          onAddToFavorite: () {
            setState(() {
              list = DataStorage.allFavorite();
            });
          },
        );
      },
      itemCount: list.length,
    );
  }
}
