
import 'package:reach_collect/data/model/anc_model';
import 'package:reach_collect/data/model/reach_model.dart';
import 'package:reach_collect/network/presistance/database_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const int DATABASE_VERSION = 1;
  static const String DATABASE_NAME = "reachdb";
  static const String TEXT_TYPE = " TEXT";
  static const String INTEGER_TYPE = " INTEGER";
  static const String BOOL_TYPE = 'INTEGER';
  static const String DOUBLE_TYPE = " REAL";
  static const String INTEGER_AUTO_INCREMENT =
      " INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL";

  //Medical Table
static const String SQL_CREATE_ACN_TABLE =
      "CREATE TABLE ${AncRegisterTable.TABLE_NAME} (${AncRegisterTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,${AncRegisterTable.COLUMM_ORG_NAME}$TEXT_TYPE,${AncRegisterTable.COLUMM_STATE_NAME}$TEXT_TYPE,${AncRegisterTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,${AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,${AncRegisterTable.COLUMM_REPORTING_UNIT}$TEXT_TYPE,${AncRegisterTable.COLUMM_CLINIC}$TEXT_TYPE,${AncRegisterTable.COLUMM_CHANNEL}$TEXT_TYPE,${AncRegisterTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Name}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Age}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Date}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Disability}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_IDP}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Gestational}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Gravida}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Parity}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Td}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Findings}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Treatment}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Attended}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Outcome}$TEXT_TYPE,${AncRegisterTable.COLUMN_NAME_Remark}$TEXT_TYPE)";

static const String SQL_CREATE_DELIVERY_TABLE = "CREATE TABLE ${DeliveryTable.TABLE_NAME} (${DeliveryTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
    "${DeliveryTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
    "${DeliveryTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
    "${DeliveryTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
    "${DeliveryTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
    "${DeliveryTable.COLUMM_REPORTING_UNIT}$TEXT_TYPE,"
    "${DeliveryTable.COLUMM_CLINIC}$TEXT_TYPE,"
    "${DeliveryTable.COLUMM_CHANNEL}$TEXT_TYPE,"
    "${DeliveryTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Date}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Name}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Age}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_SEX}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_IDP}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Gestational}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Gravida}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_TD_COMPLETE}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_BIRTH_TYPE}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_BREASTFEEDING}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Treatment}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Attended}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Outcome}$TEXT_TYPE,"
    "${DeliveryTable.COLUMN_NAME_Remark}$TEXT_TYPE)";

  static const String SQL_CREATE_SRH_TABLE = "CREATE TABLE ${SRHTable.TABLE_NAME} (${SRHTable.COLUMM_Id} $INTEGER_AUTO_INCREMENT,"
      "${SRHTable.COLUMM_ORG_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_STATE_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_TOWNSHIP_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_TOWNSHIP_LOCAL_NAME}$TEXT_TYPE,"
      "${SRHTable.COLUMM_REPORTING_UNIT}$TEXT_TYPE,"
      "${SRHTable.COLUMM_CLINIC}$TEXT_TYPE,"
      "${SRHTable.COLUMM_CHANNEL}$TEXT_TYPE,"
      "${SRHTable.COLUMM_REPORTING_PERIOD}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Date}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Name}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Age}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_SEX}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Disability}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_IDP}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_SERVICE_TYPE}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_FIRST_REACH}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_FP_COMMODITY}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_FP_QUANTITY}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_FANDP_DIAGNOSIS}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Treatment}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Attended}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Outcome}$TEXT_TYPE,"
      "${SRHTable.COLUMN_NAME_Remark}$TEXT_TYPE)";

DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    //databaseFactory.deleteDatabase(dbPath);
    return await openDatabase(join(dbPath, DATABASE_NAME),
        version: DATABASE_VERSION,
        onCreate: (Database database, int version) async {
      await database.execute(SQL_CREATE_ACN_TABLE);
      await database.execute(SQL_CREATE_DELIVERY_TABLE);
      await database.execute(SQL_CREATE_SRH_TABLE);
    });
  }

  Future insertDataToDB(ANCVo acnVo) async {
    final db = await database;
    Batch batch = db.batch();

    var data = <String, dynamic>{
      // ReachCollectTable.COLUMM_Id: reachCollectVo.id,
      AncRegisterTable.COLUMM_ORG_NAME: acnVo.orgName,
      AncRegisterTable.COLUMM_STATE_NAME: acnVo.stateName,
      AncRegisterTable.COLUMM_TOWNSHIP_NAME: acnVo.townshipName,
      AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME: acnVo.townshipLocalName,
      AncRegisterTable.COLUMM_REPORTING_UNIT: acnVo.reportingUnit,
      AncRegisterTable.COLUMM_CLINIC: acnVo.clinic,
      AncRegisterTable.COLUMM_CHANNEL: acnVo.channel,
      AncRegisterTable.COLUMM_REPORTING_PERIOD: acnVo.reportingPeroid,
      AncRegisterTable.COLUMN_NAME_Name: acnVo.name,
      AncRegisterTable.COLUMN_NAME_Age: acnVo.age,
      AncRegisterTable.COLUMN_NAME_Date: acnVo.date,
      AncRegisterTable.COLUMN_NAME_Disability: acnVo.disability,
      AncRegisterTable.COLUMN_NAME_IDP: acnVo.idp,
      AncRegisterTable.COLUMN_NAME_Gestational: acnVo.gestational,
      AncRegisterTable.COLUMN_NAME_Gravida: acnVo.gravida,
      AncRegisterTable.COLUMN_NAME_Parity: acnVo.parity,
      AncRegisterTable.COLUMN_NAME_Findings: acnVo.findings,
      AncRegisterTable.COLUMN_NAME_Td: acnVo.td,
      AncRegisterTable.COLUMN_NAME_Treatment: acnVo.treatment,
      AncRegisterTable.COLUMN_NAME_Attended: acnVo.attended,
      AncRegisterTable.COLUMN_NAME_Outcome: acnVo.outcome,
      AncRegisterTable.COLUMN_NAME_Remark: acnVo.remark,
    };
    //inset village
    batch.insert(AncRegisterTable.TABLE_NAME, data,
        conflictAlgorithm: ConflictAlgorithm.abort);

    batch.commit();
    return;
  }

  Future<List<ANCVo>> getAllDataFromDB() async {
    final db = await database;
    List<ANCVo> reachCollectData = [];
    dynamic reachCollectValue = await db.rawQuery(
        "SELECT * FROM '${AncRegisterTable.TABLE_NAME}';", null);

    for (var reachCollect in reachCollectValue) {
      ANCVo ancVo = ANCVo();
      ancVo.id = reachCollect[AncRegisterTable.COLUMM_Id];
      ancVo.orgName = reachCollect[AncRegisterTable.COLUMM_ORG_NAME];
      ancVo.stateName = reachCollect[AncRegisterTable.COLUMM_STATE_NAME];
      ancVo.townshipName = reachCollect[AncRegisterTable.COLUMM_TOWNSHIP_NAME];
      ancVo.townshipLocalName = reachCollect[AncRegisterTable.COLUMM_TOWNSHIP_LOCAL_NAME];
      ancVo.reportingUnit = reachCollect[AncRegisterTable.COLUMM_REPORTING_UNIT];
      ancVo.clinic = reachCollect[AncRegisterTable.COLUMM_CLINIC];
      ancVo.channel = reachCollect[AncRegisterTable.COLUMM_CHANNEL];
      ancVo.reportingPeroid = reachCollect[AncRegisterTable.COLUMM_REPORTING_PERIOD];
      ancVo.age = reachCollect[AncRegisterTable.COLUMN_NAME_Age];
      ancVo.name = reachCollect[AncRegisterTable.COLUMN_NAME_Name];
      ancVo.date = reachCollect[AncRegisterTable.COLUMN_NAME_Date];
      ancVo.disability =
          reachCollect[AncRegisterTable.COLUMN_NAME_Disability];
      ancVo.idp = reachCollect[AncRegisterTable.COLUMN_NAME_IDP];
      ancVo.gestational =
          reachCollect[AncRegisterTable.COLUMN_NAME_Gestational];
      ancVo.gravida =
          reachCollect[AncRegisterTable.COLUMN_NAME_Gravida];
      ancVo.parity =
          reachCollect[AncRegisterTable.COLUMN_NAME_Parity];
      ancVo.td = reachCollect[AncRegisterTable.COLUMN_NAME_Td];
      ancVo.findings =
          reachCollect[AncRegisterTable.COLUMN_NAME_Findings];
      ancVo.treatment =
          reachCollect[AncRegisterTable.COLUMN_NAME_Treatment];
      ancVo.attended =
          reachCollect[AncRegisterTable.COLUMN_NAME_Attended];
      ancVo.outcome =
          reachCollect[AncRegisterTable.COLUMN_NAME_Outcome];
      ancVo.remark =
          reachCollect[AncRegisterTable.COLUMN_NAME_Remark];
      reachCollectData.add(ancVo);
    }
    return reachCollectData;
  }

  Future deleteFromDB(int id) async {
    final db = await database;
    Batch batch = db.batch();
    batch.delete(AncRegisterTable.TABLE_NAME,
        where: 'id = ?', whereArgs: [id]);
    batch.commit();
    return;
  }

  Future updateUserInto(ANCVo reachVo) async {
    final db = await database;
    Batch batch = db.batch();
    batch.update(AncRegisterTable.TABLE_NAME,reachVo.toMap(),
        where: 'id = ?', whereArgs: [reachVo.id],);
    await batch.commit();
    return;
  }
}
