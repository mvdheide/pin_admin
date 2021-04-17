import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:pin_admin/Util/dbLayout.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DataProvider {
  DataProvider._();
  static final DataProvider db = DataProvider._();

  _DatabaseHandler _databaseHandler = _DatabaseHandler();

//----------------------------------------------------------------------------//

  Future<String> getDBPath() async => _databaseHandler.getDBPath();

//----------------------------------------------------------------------------//

  Future<List<Map>> getOverviewList(
      String? filterShopParam,
      String? filterPlaceParam,
      String? filterTMSParam,
      int buttonNRParam,
      bool ascendingParam) async {
    // final db = await (_databaseHandler.database as FutureOr<Database?>);
    final db = await _databaseHandler.database;

    return await db!.query("BEANET1",
        columns: DBColumns.getOverviewListColumns(),
        where: DBColumns.getShopColumnName() +
            " LIKE ? AND " +
            DBColumns.getPlaceColumnName() +
            " LIKE ? AND " +
            DBColumns.getTMSColumnName() +
            " LIKE ?",
        whereArgs: [
          "%$filterShopParam%",
          "%$filterPlaceParam%",
          "%$filterTMSParam%"
        ],
        orderBy: DBColumns.getButtonColumns()[buttonNRParam] +
            " " +
            (ascendingParam ? "ASC" : "DESC"));
  }

//----------------------------------------------------------------------------//

  Future<List<Map<String, Object?>>> getDetails(int _idParam) async {
    // final db = await (_databaseHandler.database as FutureOr<Database?>);
    final db = await _databaseHandler.database;
    return await db!.query("BEANET1",
        where: DBColumns.idColumnName + " = ? ", whereArgs: [_idParam]);
  }

//----------------------------------------------------------------------------//

}

//----------------------------------------------------------------------------//

class _DatabaseHandler {
  static Database? _database;
  static const String _databaseFilename = "mabTD.db";

//----------------------------------------------------------------------------//

  Future<Database?> get database async {
    // if (_database != null) return _database;
    // _database = await _initDB();
    if (_database == null) {
      _database = await _initDB();
    }
    return _database;
  }

//----------------------------------------------------------------------------//

  Future<String> getDBPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, _databaseFilename);
  }

//----------------------------------------------------------------------------//

  Future<Database> _initDB() async {
    String path;
    if (kIsWeb) {
      path = '/database/' + _databaseFilename;
      return await databaseFactory.openDatabase(inMemoryDatabasePath);
    } else {
      path = await getDBPath();
      var exists = await databaseExists(path);
      if (!exists) {
        // Should happen only the first time you launch your application
        print("initDB() - Creating new copy from asset");

        // Make sure the parent directory exists
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        // Copy from asset
        ByteData data =
            await rootBundle.load(join("database", _databaseFilename));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Write and flush the bytes written
        await File(path).writeAsBytes(bytes, flush: true);
      } else {
        print("initDB() - Opening existing database");
      }
      print("initDB() - done en start van open: $path");
      return await openDatabase(path, readOnly: true, onOpen: (db) {});
    }
  }

//----------------------------------------------------------------------------//

}
