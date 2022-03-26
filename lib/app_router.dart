import 'package:flutter/material.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_view.dart';
import 'package:suwariyomi/views/doujin/doujin_library/library_view.dart';

import 'constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LibraryPage(
            key: Constants.HOME_KEY,
            title: Constants.APP_TITLE,
          ),
        );

      case '/details':
        return MaterialPageRoute(
          builder: (_) {
            return DoujinDetailsPage(
              id: settings.arguments as int,
            );
          },
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
