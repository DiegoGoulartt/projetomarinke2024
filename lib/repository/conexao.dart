// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PalletConexao {
  static const _dbname = "pallet.db";
  static const _sqlscript =
      'CREATE TABLE pallet(id INTEGER PRIMARY KEY AUTOINCREMENT, motorista TEXT, veiculo TEXT);';

  static const table = 'pallet';
  static const columnId = 'id';
  static const columnMotorista = 'motorista';
  static const columnVeiculo = 'veiculo';

  //singleton
  PalletConexao._privateConstructor();
  static final PalletConexao instance = PalletConexao._privateConstructor();
  // tem somente uma referência ao banco de dados - com safenull
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbname),
      onCreate: (db, version) {
        return db.execute(_sqlscript);
      },
      version: 1,
    );
  }
}