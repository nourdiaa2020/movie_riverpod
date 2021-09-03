import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/controllers/movie_detail_controller.dart';
import 'package:movie_app_riverpod/src/utils/my_scroll_behavior.dart';
import 'package:movie_app_riverpod/src/widgets/movie_gallery.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  State createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final controller = watch(getMovieByIdProvider(widget.movieId));
          return controller.map(
            data: (value) {
              final model = value.value;
              return Stack(
                children: <Widget>[
                  ScrollConfiguration(
                    behavior: MyScrollBehavior(),
                    child: SingleChildScrollView(
                        child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              var width = constraints.biggest.width;
                              return Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ClipPath(
                                          clipper: Mclipper(),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(0.0, 10.0),
                                                      blurRadius: 10.0)
                                                ]),
                                            child: Container(
                                              width: width,
                                              height: width,
                                              child: Image.network(
                                                 model.posterPath,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    model.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Muli"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "genresValue".toString(),
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Muli"),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: RatingBarIndicator(
                                    itemSize: 25,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    rating: model.voteAverage / 2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(),
                                      ),
                                      _buildMovieMoreInfoItem(
                                          "Year", model.releaseDate.substring(0, 4)),
                                      _buildMovieMoreInfoItem("Country",
                                          model.countryName.toString()),
                                      _buildMovieMoreInfoItem(
                                          "Length", "${model.runtime.toString()} min"),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    model.overview,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      // Row(
                                      //   children: <Widget>[
                                      //     Expanded(
                                      //       child: Text(
                                      //         "Screenshots",
                                      //         style: TextStyle(
                                      //             color: Colors.black,
                                      //             fontSize: 16.0,
                                      //             fontWeight: FontWeight.bold,
                                      //             fontFamily: "Muli"),
                                      //       ),
                                      //     ),
                                      //     Icon(
                                      //       Icons.arrow_forward,
                                      //       color: Colors.black,
                                      //     )
                                      //   ],
                                      // ),
                                      // MovieGallery(
                                      //   movieId: 5, //movieId,
                                      // )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                  Positioned(
                    //Place it at the top, and not use the entire screen
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: AppBar(
                      brightness: Brightness.light,
                      iconTheme: IconThemeData(
                        color: Colors.black, //change your color here
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      //No more green
                    ),
                  ),
                ],
              );
            },
            loading: (x) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (value) => Center(
              child: Text(value.toString()),
            ),
          );
        },
      ),
    );
  }

  _buildMovieMoreInfoItem(String title, String value) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: constraints.biggest.width > 100 ? 100 : double.infinity,
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                   ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Wrap(
              children: <Widget>[
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                       ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 40.0);

    var controlPoint = Offset(size.width / 4, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endpoint.dx, endpoint.dy);

    var controlPoint2 = Offset(size.width * 3 / 4, size.height);
    var endpoint2 = Offset(size.width, size.height - 40.0);

    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endpoint2.dx, endpoint2.dy);

    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
