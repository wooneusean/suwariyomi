import 'dart:convert';

import 'package:flutter_test/flutter_test.dart' as t;
import 'package:sembast/sembast.dart';
import 'package:suwariyomi/classes/doujin.dart';
import 'package:suwariyomi/helpers/doujin_helper.dart';
import 'package:suwariyomi/providers/doujin_provider.dart';

void main() {
  t.group("DoujinProvider methods", () {
    final doujinProvider = DoujinProvider();

    t.test("Doujin should be inserted", () async {
      final doujin = await DoujinHelper.scrape(101113);

      t.expect(doujin?.id, 101113);

      print(doujin);

      await doujinProvider.insert(doujin!);

      var insertedDoujin = await doujinProvider.retrieve(101113);

      print(insertedDoujin);

      t.expect(insertedDoujin.id, doujin.id);
    }, skip: "Re-enable when testing this part, skipped to improve testing speed.");

    t.test("Doujin should be updated", () async {
      // Remove this when the first test is enabled.
      await doujinProvider.insert(Doujin.fromJson(jsonDecode(
          """{"date_added":1640355142,"id":101113,"images":{"cover":{"t":"p"}},"media_id":"646209","rating":10,"scanlator":"","tags":[{"name":"noise","type":"artist"},{"name":"english","type":"language"},{"name":"translated","type":"language"},{"name":"lolicon","type":"tag"},{"name":"defloration","type":"tag"},{"name":"oppailoli","type":"tag"},{"name":"hotpants","type":"tag"},{"name":"manga","type":"category"},{"name":"sweating","type":"tag"},{"name":"solefemale","type":"tag"},{"name":"solemale","type":"tag"}],"title":{"english":"[Noise]OkashinaKo(COMICLO2013-09)[English][biribiri]","japanese":"[Noise]お菓子な子(COMICLO2013年9月号)[英訳]","pretty":"OkashinaKo"},"upload_date":1404000701}""")));

      final doujin = await doujinProvider.retrieve(101113);

      t.expect(doujin.rating, 0);

      print(doujin);

      doujin.rating = 10;

      await doujinProvider.update(101113, doujin);

      final updatedDoujin = await doujinProvider.retrieve(101113);

      print(updatedDoujin);

      t.expect(updatedDoujin.rating, 10);
    });

    t.test("Doujin update should fail if invalid ID", () async {
      final doujin = await doujinProvider.retrieve(101113);

      t.expect(doujin.rating, 10);

      print(doujin);

      doujin.rating = 0;

      t.expect(() async => await doujinProvider.update(900000, doujin), t.throwsException);

      final updatedDoujin = await doujinProvider.retrieve(101113);

      print(updatedDoujin);

      t.expect(updatedDoujin.rating, 10);
    });

    t.test("Doujin should be deleted", () async {
      t.expect(() async => await doujinProvider.delete(101113), t.returnsNormally);
    });

    t.test("An error should be shown if doujin does not exist when deleting", () async {
      t.expect(() async => await doujinProvider.delete(101113), t.throwsException);
    });

    t.test("All data should be retrieved", () async {
      var data = [
        Doujin.fromJson(jsonDecode(
            """{"date_added":1640424430,"id":61981,"images":{"cover":{"t":"j"}},"media_id":"374884","rating":9,"scanlator":"","tags":[{"name":"bigbreasts","type":"tag"},{"name":"swimsuit","type":"tag"},{"name":"meme50","type":"artist"},{"name":"english","type":"language"},{"name":"ahegao","type":"tag"},{"name":"translated","type":"language"},{"name":"darkskin","type":"tag"},{"name":"x-ray","type":"tag"},{"name":"fullcolor","type":"tag"},{"name":"paizuri","type":"tag"},{"name":"manga","type":"category"}],"title":{"english":"[Meme50]MizugiwaSabotage|Sabotageatthewater'sedge[English]=TeamVanilla=","japanese":"[メメ50]水際さぼタージュ[英訳]","pretty":"MizugiwaSabotage|Sabotageatthewater'sedge"},"upload_date":1403993617}""")),
        Doujin.fromJson(jsonDecode(
            """{"date_added":1640421475,"id":74467,"images":{"cover":{"t":"j"}},"media_id":"482201","rating":10,"scanlator":"","tags":[{"name":"mayochiki","type":"parody"},{"name":"bigbreasts","type":"tag"},{"name":"takedahiromitsu","type":"artist"},{"name":"kanadesuzutsuki","type":"character"},{"name":"swimsuit","type":"tag"},{"name":"farting","type":"tag"},{"name":"humiliation","type":"tag"},{"name":"netorare","type":"tag"},{"name":"shinjugai","type":"group"},{"name":"english","type":"language"},{"name":"moraldegeneration","type":"tag"},{"name":"ahegao","type":"tag"},{"name":"anal","type":"tag"},{"name":"translated","type":"language"},{"name":"subaru","type":"character"},{"name":"subarukonoe","type":"character"},{"name":"defloration","type":"tag"},{"name":"mindbreak","type":"tag"},{"name":"rape","type":"tag"},{"name":"bbm","type":"tag"},{"name":"doujinshi","type":"category"},{"name":"schoolgirluniform","type":"tag"},{"name":"blackmail","type":"tag"},{"name":"tickling","type":"tag"},{"name":"maid","type":"tag"},{"name":"stockings","type":"tag"},{"name":"glasses","type":"tag"}],"title":{"english":"(C81)[Shinjugai(TakedaHiromitsu)]MayoTama!!(MayoChiki!)[English]{doujin-moe.us}","japanese":"(C81)[真珠貝(武田弘光)]まよタマ!!(まよチキ!)[英訳]","pretty":"MayoTama!!"},"upload_date":1403995826}""")),
        Doujin.fromJson(jsonDecode(
            """{"date_added":1643651164,"id":74783,"images":{"cover":{"t":"j"}},"media_id":"485058","rating":8,"scanlator":"","tags":[{"name":"bigbreasts","type":"tag"},{"name":"swimsuit","type":"tag"},{"name":"group","type":"tag"},{"name":"netorare","type":"tag"},{"name":"nanatsunokagiana","type":"group"},{"name":"english","type":"language"},{"name":"ahegao","type":"tag"},{"name":"anal","type":"tag"},{"name":"translated","type":"language"},{"name":"x-ray","type":"tag"},{"name":"fullcolor","type":"tag"},{"name":"nanakagisatoshi","type":"artist"},{"name":"bokuwatomodachigasukunai","type":"parody"},{"name":"doublepenetration","type":"tag"},{"name":"senakashiwazaki","type":"character"},{"name":"bukkake","type":"tag"},{"name":"mindbreak","type":"tag"},{"name":"rape","type":"tag"},{"name":"doujinshi","type":"category"},{"name":"schoolgirluniform","type":"tag"}],"title":{"english":"[NanatsunoKagiana(NanakagiSatoshi)]HoshinoWaltz(BokuwaTomodachigaSukunai)[English]{doujin-moe.us}[Digital]","japanese":"[七つの鍵穴(七鍵智志)]星の輪姦(僕は友達が少ない)[英訳][DL版]","pretty":"HoshinoWaltz"},"upload_date":1403995883}""")),
        Doujin.fromJson(jsonDecode(
            """{"date_added":1640421597,"id":85719,"images":{"cover":{"t":"j"}},"media_id":"539656","rating":8,"scanlator":"","tags":[{"name":"maid","type":"tag"},{"name":"futanari","type":"tag"},{"name":"bigbreasts","type":"tag"},{"name":"swimsuit","type":"tag"},{"name":"nurse","type":"tag"},{"name":"group","type":"tag"},{"name":"glasses","type":"tag"},{"name":"bigass","type":"tag"},{"name":"ahegao","type":"tag"},{"name":"hugebreasts","type":"tag"},{"name":"anal","type":"tag"},{"name":"sextoys","type":"tag"},{"name":"harem","type":"tag"},{"name":"nagaraya","type":"artist"},{"name":"bikini","type":"tag"},{"name":"x-ray","type":"tag"},{"name":"fullcolor","type":"tag"},{"name":"tanlines","type":"tag"},{"name":"lactation","type":"tag"},{"name":"stockings","type":"tag"},{"name":"smallbreasts","type":"tag"},{"name":"bloomers","type":"tag"},{"name":"japanese","type":"language"},{"name":"manga","type":"category"},{"name":"schoolgirluniform","type":"tag"},{"name":"tankoubon","type":"tag"},{"name":"mosaiccensorship","type":"tag"}],"title":{"english":"[Nagaraya]Nyuuton","japanese":"[ながら屋]乳豚","pretty":"Nyuuton"},"upload_date":1403997780}""")),
        Doujin.fromJson(jsonDecode(
            """{"date_added":1640355142,"id":101113,"images":{"cover":{"t":"p"}},"media_id":"646209","rating":10,"scanlator":"","tags":[{"name":"noise","type":"artist"},{"name":"english","type":"language"},{"name":"translated","type":"language"},{"name":"lolicon","type":"tag"},{"name":"defloration","type":"tag"},{"name":"oppailoli","type":"tag"},{"name":"hotpants","type":"tag"},{"name":"manga","type":"category"},{"name":"sweating","type":"tag"},{"name":"solefemale","type":"tag"},{"name":"solemale","type":"tag"}],"title":{"english":"[Noise]OkashinaKo(COMICLO2013-09)[English][biribiri]","japanese":"[Noise]お菓子な子(COMICLO2013年9月号)[英訳]","pretty":"OkashinaKo"},"upload_date":1404000701}"""))
      ];

      await doujinProvider.insertAll(data);

      var doujins = await doujinProvider.retrieveAll();

      print(doujins.first);

      t.expect(doujins.length, 5);
    });

    t.test("Only filtered data should be retrieved", () async {
      var doujins = await doujinProvider.retrieveAll(
        finder: Finder(
          filter: Filter.custom(
            (record) => (record['tags'] as Iterable).any((element) => element['name'] == "swimsuit"),
          ),
        ),
      );
      t.expect(doujins.length, 4);
    });

    doujinProvider.deleteDb();
  });
}
