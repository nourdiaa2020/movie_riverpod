import 'package:flutter/material.dart';

class MovieGallery extends StatefulWidget {
  final int movieId;

  MovieGallery({Key? key,required this.movieId}) : super(key: key);

  @override
  _MovieGalleryState createState() => _MovieGalleryState();
}

class _MovieGalleryState extends State<MovieGallery> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isFirst = true;

    /// change
    var imagePath = "";
    return Container(
      height: width / 3,
      margin: EdgeInsets.only(bottom: 50, top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,

        /// item count
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin:
                EdgeInsets.only(left: isFirst ? 0 : 10, right: 10, bottom: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Image.network(
              'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              width: (width / 3) * 4 / 3,
              height: (width / 3) / 2,
            ),
          );
        },
      ),
    );
  }
}
