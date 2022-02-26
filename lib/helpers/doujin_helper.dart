import 'dart:convert';

import '../classes/doujin.dart';
import 'package:http/http.dart' as http;

class DoujinHelper {
  static Future<Doujin?> scrape(int id) async {
    final html = await http.get(Uri.parse('https://www.nhentai.net/g/$id'));

    final regExp = RegExp(r'(?:window\._gallery = JSON\.parse\((\".+?\")\);)');

    final match = regExp.firstMatch(html.body);

    if (match == null) return null;

    return Doujin.fromJson(jsonDecode(jsonDecode(match.group(1) ?? '{}')));
  }
}
