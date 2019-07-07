import 'dart:io';
import 'package:my_first_app/Model/Movies.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MoviesDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Movie ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "overview TEXT,"
          "poster_path TEXT,"
          "release_date TEXT,"
          "original_language TEXT"
          ")");
    });
  }


newMovie(Results newMovie) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Movie");
    int id = table.first["id"];
    //insert to the table using the new id 
    var raw = await db.rawInsert(
        "INSERT Into Movie (id,title,overview,poster_path,release_date,original_language)"
        " VALUES (?,?,?,?,?,?)",
        [id, newMovie.title, newMovie.overview, newMovie.posterPath,newMovie.releaseDate,newMovie.originalLanguage]);
    return raw;
  }


  getClient(int id) async {
    final db = await database;
    var res =await  db.query("Movie", where: "id = ?", whereArgs: [id]);
    var mv =  res.isNotEmpty ? Results.fromJson(res.first) : Null ;
    return mv ;
  }

}