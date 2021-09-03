import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/controllers/home_controller.dart';
import 'package:movie_app_riverpod/src/screens/favorite_tab.dart';
import 'package:movie_app_riverpod/src/screens/home_tab.dart';
import 'package:movie_app_riverpod/src/screens/search_screen.dart';

class HomeBase extends ConsumerWidget {
  const HomeBase();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(homeController.notifier);
    final currentIndex = watch(homeController);
    final isHomeTab = currentIndex == 0;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isHomeTab ? "Home" : "Favorite"),
          actions: isHomeTab
              ? [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  )
                ]
              : [],
          elevation: 0,
          centerTitle: true,
        ),
        body: isHomeTab ? HomeTab() : FavoriteTab(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: controller.changeTabIndex,
          enableFeedback: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              label: 'Movie',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'favorite',
            ),
          ],
        ),
      ),
    );
  }
}
