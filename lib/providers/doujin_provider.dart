import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:suwariyomi/classes/doujin.dart';

class DoujinProvider {
  static final DoujinProvider _instance = DoujinProvider._internal();
  final _dbPath = 'doujins.db';

  factory DoujinProvider() {
    return _instance;
  }

  DoujinProvider._internal() {}

  Future<String> getDbPath() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    return Path.join(dir.path, _dbPath);
  }

  Future deleteDb() async {
    var dbPath = await getDbPath();
    await databaseFactoryIo.deleteDatabase(dbPath);
  }

  Future<Database> open() async {
    var dbPath = await getDbPath();
    return databaseFactoryIo.openDatabase(dbPath);
  }

  Future<Doujin> retrieve(int id) async {
    var store = StoreRef.main();
    var db = await open();

    var retrievedRecord = await store.record(id).get(db);

    if (retrievedRecord == null)
      throw Exception('Record with provided ID does not exist');

    db.close();

    return Doujin.fromJson(retrievedRecord);
  }

  Future<List<Doujin>> retrieveAll({Finder? finder}) async {
    var store = StoreRef.main();
    var db = await open();

    var records = (await store.find(db, finder: finder))
        .map((e) => Doujin.fromJson(e.value))
        .toList();

    return records;
  }

  Future<Doujin> insert(Doujin doujin, {int? key}) async {
    var store = StoreRef.main();
    var db = await open();

    if (key == null && doujin.id == null)
      throw Exception('Both provided key and Record ID is null');

    doujin.dateAdded = DateTime.now().millisecondsSinceEpoch;
    doujin.rating = 0;

    var recordExists = await store.record(key ?? doujin.id!).get(db) != null;

    if (recordExists) throw Exception('Record already exists in database');

    var storedRecord =
        await store.record(key ?? doujin.id!).put(db, doujin.toJson());

    await db.close();

    return Doujin.fromJson(storedRecord);
  }

  Future insertAll(List<Doujin> data) async {
    var store = StoreRef.main();
    var db = await open();

    await db.transaction((txn) async {
      await Future.wait(data.map((e) {
        return store.record(e.id).put(txn, e.toJson());
      }));

      //     async {
      //   if (doujin == null)
      //     return;
      //   await store.record(doujin.id).put(txn, doujin.toJson());
      // });
    });
  }

  Future<Doujin> update(int key, Doujin value) async {
    var store = StoreRef.main();
    var db = await open();

    var insertedRecord = await store.record(key).update(db, value.toJson());

    db.close();

    if (insertedRecord == null) throw Exception('Record does not exist');

    return Doujin.fromJson(insertedRecord);
  }

  Future delete(int key) async {
    var store = StoreRef.main();
    var db = await open();

    int? deletedKey = await store.record(key).delete(db);

    db.close();

    if (deletedKey == null) throw Exception('Record does not exist');
  }
}
