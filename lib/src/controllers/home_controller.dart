import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final homeController = StateNotifierProvider<HomeController,int>((ref) => HomeController());

class HomeController extends StateNotifier<int> {
  DateTime? currentBackPressTime;

  HomeController() : super(0);
  void changeTabIndex(int newIndex) {
    state = newIndex;
  }
  Future<bool> onWillPop() {
    final now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "double Tab To Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
