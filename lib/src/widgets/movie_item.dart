import 'package:flutter/material.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:movie_app_riverpod/src/screens/movie_detail_page.dart';
import 'package:movie_app_riverpod/src/utils/data_storage.dart';
import 'package:share/share.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function() onAddToFavorite;
  final bool isFromFav;

  MovieItem({
    this.isFromFav: false,
    required this.movie,
    required this.onAddToFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(
                movieId: movie.id,
              ),
            ));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        child: GridTile(
          footer: Center(
              child: Container(
            padding: EdgeInsets.all(5),
            child: Text(
              movie.title,
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.circular(10)),
          )),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
              isFromFav
                  ? Positioned(
                      top: 5,
                      right: 5,
                      child: InkWell(
                        onTap: () {
                          /// to do add to favorite
                          DataStorage.saveOrDeleteFavorite(movie);
                          onAddToFavorite();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            movie.isInFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              // Positioned(
              //   top: 5,
              //   left: 5,
              //   child: InkWell(
              //     onTap: () async {
              //       await Share.share(movie.shareLinkUrl);
              //     },
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Icon(
              //         Icons.share,
              //         color: Colors.white,
              //       ),
              //       decoration: BoxDecoration(
              //         color: Colors.grey.withOpacity(.9),
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
