import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DataProvider {
  DataProvider._();
  static final DataProvider db = DataProvider._();
  static Database _database;
  List<String> buttonColumns = [
    "displayName",
    "Plaats",
    "tmsNR",
    "shopNR",
    "kassanum"
  ];

  // static List<Map<dynamic, dynamic>> overviewList;
  // String path;

  // DataProvider() {
  //   openDB();
  // }

  // List<Map> getList() {
  //   List<Map> resultList = await getListexecOverviewListQuery();
  //   return resultList;
  // }

  Future<Database> get database async {
    if (_database != null) return _database;
    // print("get database - start");
    _database = await initDB();
    // print("get database - done");
    return _database;
  }

  // Future<List<Map>> getList() async {
  //   // var dbPath = await getDatabasesPath();
  //   // String path = dbPath + '/mabTD.db';
  //   // print(path);
  //   // db = await openDatabase(path, version: 1);
  //   final db = await database;
  //   var ope = db.isOpen;
  //   print("DataProvider.getList: dbis $ope");
  //   return await db.rawQuery(
  //       "SELECT _id,displayName,plaats,tmsNR,shopNR,kassanum FROM BEANET1");
  //   // "SELECT displayName,plaats,tmsNR,shopNR,kassanum FROM BEANET1 limit 100");
  //   // db.close();
  //   // } else {
  //   //   print("overviewlist was niet null");
  //   // }
  // }
  Future<String> getDBPath() async {
    // print("start databasesPath");
    var databasesPath = await getDatabasesPath();
    // print("opendb: getDatabasesPath: $databasesPath");
    return join(databasesPath, "mabTD.db");
  }

  initDB() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // print(documentsDirectory);
// var path = "/data/data/com.example.text_app/databases/mabTD.db";
    String path;
    if (kIsWeb) {
      path = '/database/mabTD.db';
      // print("initDB() - web, dus path = $path");
      // var databaseFactory = databaseFactoryWeb;
      return await databaseFactory.openDatabase(inMemoryDatabasePath);
    } else {
      path = await getDBPath();
      // print("initDB() - start van open: $path");
// Check if the database exists
      var exists = await databaseExists(path);
      // print("openDB: start van open: $exists");
      if (!exists) {
        // Should happen only the first time you launch your application
        print("initDB() - Creating new copy from asset");

        // Make sure the parent directory exists
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        // Copy from asset
        ByteData data = await rootBundle.load(join("database", "mabTD.db"));
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

// open the database

    // var dbPath = await getDatabasesPath();
    // String path = dbPath + '/mabTD.db';
    // print(path);
    // db = await openDatabase(path, version: 1);
  }

  Future<List<Map>> getOverviewList(
      String filterShopParam,
      String filterPlaceParam,
      String filterTMSParam,
      int buttonNRParam,
      bool ascendingParam) async {
    final db = await database;
    // var ope = db.isOpen;
    // print("filterShopParam :$filterShopParam");
    // print("DataProvider.getList: dbis $ope");
    return await db.query("BEANET1",
        columns: [
          "_id",
          "displayName",
          "plaats",
          "tmsNR",
          "shopNR",
          "kassanum"
        ],
        where: "displayName LIKE ? AND plaats LIKE ? AND tmsNR LIKE ?",
        whereArgs: [
          "%$filterShopParam%",
          "%$filterPlaceParam%",
          "%$filterTMSParam%"
        ],
        orderBy: buttonColumns[buttonNRParam] +
            " " +
            (ascendingParam ? "ASC" : "DESC"));
  }

  Future<List<Map<String, Object>>> getDetails(int _idParam) async {
    final db = await database;
    // var ope = db.isOpen;
    // print("_idParam :$_idParam");
    // print("DataProvider.getList: dbis $ope");
    return await db.query("BEANET1", where: "_id = ? ", whereArgs: [_idParam]);
  }

  Future<List<List>> getDetailsList(int _idParam) async {
    final db = await database;
    // var ope = db.isOpen;
    // print("_idParam :$_idParam");
    // print("DataProvider.getList: dbis $ope");
    var result = await db.query("BEANET1",
        // columns: [
        //   "_id",
        //   "displayName",
        //   "plaats",
        //   "tmsNR",
        //   "shopNR",
        //   "kassanum"
        // ],
        where: "_id = ? ",
        whereArgs: [_idParam]);

    // map.forEach((k, v) => list.add(Customer(k, v)));
    List<List> detailList = [
      ["hoofdKantoor", result[0]["HoofdkantoorNaam"]],
      ["naam", result[0]["displayName"]],
      ["plaats", result[0]["plaats"]],
      ["shop nummer", result[0]["shopNR"]],
      ["kassa nummer", result[0]["kassanum"]],
      ["pinpad soort", result[0]["typebetaal1"]],
      ["TMS nummer", result[0]["tmsNR"]],
      ["adres", result[0]["adres"]],
      ["postcode", result[0]["Postcode"]],
      ["plaats", result[0]["plaats"]],
      ["telefoon", result[0]["telefoon"]],
      ["ip adres", result[0]["nuaadres"]],
      ["subnetmask", result[0]["MASK"]],
      ["gateway", result[0]["GW"]],
      ["netwerk profiel", result[0]["datacommadre"]],
      ["MAC", result[0]["MAC"]],
      ["automaatcode", result[0]["betaalauto"]],
      ["TIDCCV", result[0]["TID"]],
      ["TIDAWL", result[0]["TIDAWL"]],
      ["MerchantID", result[0]["MerchantID"]],
      ["PUK GSM", result[0]["PUKGSM"]],
      ["CertCode", result[0]["CertCode"]],
      ["datum install", result[0]["datuminstall"]],
      ["Installatie", result[0]["Installatie"]],
      ["InstallatieDatum", result[0]["InstallatieDatum"]],
      ["Euro_Install_Num", result[0]["Euro_Install_Num"]],
      ["Euro_Opmerkingen", result[0]["Euro_Opmerkingen"]],
      ["pinpadserie", result[0]["pinpadserie"]],
      ["Portnumber", result[0]["Portnumber"]],
      ["verkooppuntc", result[0]["verkooppuntc"]],
    ];

    return detailList;
  }
}
