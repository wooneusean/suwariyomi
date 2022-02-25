import 'package:flutter/material.dart';
import 'package:suwariyomi/views/library_view.dart';

import 'constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LibraryPage(
            title: Constants.APP_TITLE,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No page found'),
            ),
          ),
        );
    }
  }
}
