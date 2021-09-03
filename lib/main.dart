import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_riverpod/src/screens/home_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeBase(),
    ),
  ));
}

Future setupLocator() async {
  final GetIt locator = GetIt.instance;
  locator
      .registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance);
  await locator.isReady<SharedPreferences>();
}
