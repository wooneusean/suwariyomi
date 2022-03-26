import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suwariyomi/constants.dart';
import 'package:suwariyomi/providers/doujin_provider.dart';

import 'app_router.dart';

void main() async {
  // make top bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        fontFamily: 'LeagueSpartan',
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        fontFamily: 'LeagueSpartan',
      ),
      themeMode: ThemeMode.system,
      title: Constants.APP_TITLE,
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
