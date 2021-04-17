import 'dart:core';

class DBColumns {
  static List<String> categoryTitle = [
    "Algemene Gegevens",
    "Contact Gegevens",
    "Verbinding Gegevens",
    "Contract Gegevens",
    "Overige Gegevens"
  ];

  static String idColumnName = "_id";

  static List<_DBColumn> _dbColumns = [
    _DBColumn("Hoofdkantoor", 'HoofdkantoorNaam', 0), //0
    _DBColumn("naam", 'displayName', 0), //1
    _DBColumn("plaats", 'plaats', 0), //2
    _DBColumn("shop nr", 'shopNR', 0), //3
    _DBColumn("kassa nr", 'kassanum', 0), //4
    _DBColumn("pinpad soort", 'typebetaal1', 0), //5
    _DBColumn("TMS nr", 'tmsNR', 0), //6
    _DBColumn("adres", 'adres', 1), //7
    _DBColumn("postcode", 'postcode', 1), //8
    _DBColumn("plaats", 'plaats', 1), //9
    _DBColumn("telefoon", 'telefoon', 1), //10
    _DBColumn("ip", 'nuaadres', 2), //11
    _DBColumn("subnetmask", 'MASK', 2), //12
    _DBColumn("gateway", 'GW', 2), //13
    _DBColumn("netwerk profiel", 'datacommadre', 2), //14
    _DBColumn("MAC address", 'MAC', 2), //15
    _DBColumn("TID Equens", 'betaalauto', 3), //16
    _DBColumn("TID CCV", 'TID', 3), //17
    _DBColumn("TIDAWL", 'TIDAWL', 3), //18
    _DBColumn("MerchantID", 'MerchantID', 3), //19
    _DBColumn("PUK GSM", 'PUKGSM', 4), //20
    _DBColumn("CertCode", 'CertCode', 4), //21
    _DBColumn("datum install", 'datuminstall', 4), //22
    _DBColumn("Installatie", 'Installatie', 4), //23
    _DBColumn("InstallatieDatum", 'InstallatieDatum', 4), //24
    _DBColumn("Euro_Install_Num", 'Euro_Install_Num', 4), //25
    _DBColumn("Euro_Opmerkingen", 'Euro_Opmerkingen', 4), //26
    _DBColumn("pinpadserie", 'pinpadserie', 4), //27
    _DBColumn("Portnumber", 'Portnumber', 4), //28
    _DBColumn("verkooppuntc", 'verkooppuntc', 4), //29
  ];

  static String getShopColumnName() => _dbColumns[1].columnName;
  static String getPlaceColumnName() => _dbColumns[9].columnName;
  static String getTMSColumnName() => _dbColumns[6].columnName;
  static String getShopNRColumnName() => _dbColumns[3].columnName;
  static String getKassaNRColumnName() => _dbColumns[4].columnName;

  static List<String> getButtonColumns() {
    // return ["displayName", "Plaats", "tmsNR", "shopNR", "kassanum"];
    return [
      getShopColumnName(),
      getPlaceColumnName(),
      getTMSColumnName(),
      getShopNRColumnName(),
      getKassaNRColumnName(),
    ];
  }

  static List<String> getOverviewListColumns() {
    // return ["displayName", "Plaats", "tmsNR", "shopNR", "kassanum"];
    return [
      idColumnName,
      getShopColumnName(),
      getPlaceColumnName(),
      getTMSColumnName(),
      getShopNRColumnName(),
      getKassaNRColumnName(),
    ];
  }

  static List<String> getDetailDescPerCategory(int categoryID) {
    return _dbColumns
        .where((column) => column.category == categoryID)
        .toList()
        .map((col) => col.description)
        .toList();
  }

  static List<String> getDetailColumnNamePerCategory(int categoryID) {
    return _dbColumns
        .where((column) => column.category == categoryID)
        .toList()
        .map((col) => col.columnName)
        .toList();
  }
  // static String getCategory(int categoryID) => categoryTitle;
}

class _DBColumn {
  final String description;
  final String columnName;
  final int category;

  _DBColumn(String descParam, String nameParam, int catParam)
      : this.description = descParam,
        this.columnName = nameParam,
        category = catParam;
}
