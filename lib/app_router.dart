import 'package:flutter/material.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_view.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_view_args.dart';
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

      case '/details':
        return MaterialPageRoute(
          builder: (_) => DoujinDetailsPage(
            doujinId: (settings.arguments as DoujinDetailsViewArgs).id,
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
