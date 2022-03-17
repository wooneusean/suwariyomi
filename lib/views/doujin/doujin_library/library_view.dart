import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_view_args.dart';
import 'package:suwariyomi/classes/doujin.dart';
import '../../../providers/doujin_provider.dart';
import 'doujin_card.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Doujin>? doujins;
  bool isLoading = true;

  Future<void> _retrieveDoujins() async {
    setState(() {
      isLoading = true;
    });

    var doujinProvider = DoujinProvider();

    await doujinProvider.retrieveAll().then((value) async {
      if (kReleaseMode) {
        // Real App
        if (value.isNotEmpty) {
          setState(() {
            doujins = value;
            isLoading = false;
          });
        } else {
          doujins = null;
        }
      } else {
        // Debug App
        if (value.isNotEmpty) {
          setState(() {
            doujins = value;
            isLoading = false;
          });
        } else {
          // Delete db
          await doujinProvider.deleteDb();
          await seedDb().then((value) {
            doujins = value;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveDoujins();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<List<Doujin>> seedDb() async {
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

    var doujinProvider = DoujinProvider();

    await doujinProvider.insertAll(data);

    data.map((e) => debugPrint(e.toString()));

    doujinProvider
        .retrieveAll()
        .then((value) => {debugPrint(value.length.toString())});

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : doujins == null || doujins?.length == 0
              ?
              // If Doujins does not exist
              Center(
                  child: FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    widthFactor: 0.5,
                    child: Text(
                      'You currently do not have any doujins as favourite',
                      style: TextStyle(fontSize: 20.0, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              :
              // If Doujins exist
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.3),
                  ),
                  itemCount: doujins?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = doujins?[index];

                    return GridTile(
                      child: DoujinCard(
                          cover: item?.cover ?? 'Error',
                          mediaId: item?.mediaId ?? 'Error',
                          title: item?.title.toString() ?? 'Error',
                          rating: item?.rating ?? 4,
                          id: item?.id ?? 123123),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: For testing purposes, remove later
          Navigator.of(context).pushNamed(
            '/details',
            arguments: DoujinDetailsViewArgs(101113),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
