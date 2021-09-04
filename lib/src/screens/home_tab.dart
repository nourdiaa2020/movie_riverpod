import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/controllers/movie_pagination_controller.dart';
import 'package:movie_app_riverpod/src/repository/home_movie_state.dart';
import 'package:movie_app_riverpod/src/repository/movie_repo.dart';
import 'package:movie_app_riverpod/src/widgets/movie_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, watch, child) {
              final f = watch(homeRecentProvider);
              return f.map(
                data: (data) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * .35),
                    items: data.value.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.network(
                                    i.posterPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    i.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }).toList(),
                  );
                },
                loading: (loading) => CircularProgressIndicator.adaptive(),
                error: (error) => Text(error.toString()),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          Consumer(builder: (context, watch, child) {
            final f = watch(homeGenericProvider);
            return f.map(
              data: (data) {
                return SizedBox(
                  height: 50,
                  child: ListView.separated(
                    itemCount: data.value.length,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          final id = data.value[index].id;
                          // watch(homeMovieProvider(28));
                          context.read(homeMovieState.notifier).getDataById(id);
                          // todo update the screen
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .29,
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(5),
                          child: Center(child: Text(data.value[index].name)),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
              loading: (loading) => CircularProgressIndicator.adaptive(),
              error: (error) => Text(error.toString()),
            );
          }),
          SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, watch, child) {
              final list = watch(homeMovieState);
              if (list.isEmpty) return CircularProgressIndicator.adaptive();
              return GridView.builder(
                padding: EdgeInsets.all(5),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isPortrait ? 2 : 3,
                  crossAxisSpacing: 5,
                  childAspectRatio: .7,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  // use the index for pagination
                  // paginationController.handleScrollWithIndex(index);
                  return MovieItem(
                    movie: list[index],
                    onAddToFavorite: () {
                      /// todo we need to refresh the list
                      context
                          .refresh(moviePaginationControllerProvider)
                          .refreshMovies(list[index].id);
                    },
                  );
                },
                itemCount: list.length,
              );

              final paginationController =
                  watch(moviePaginationControllerProvider.notifier);
              final paginationState = watch(moviePaginationControllerProvider);

              return Builder(
                builder: (context) {
                  if (paginationState.refreshError) {
                    return _ErrorBody(message: paginationState.errorMessage);
                  } else if (paginationState.movies.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    padding: EdgeInsets.all(5),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
            },
          ),
        ],
      ),
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
