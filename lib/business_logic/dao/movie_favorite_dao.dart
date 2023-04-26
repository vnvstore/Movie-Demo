import 'dart:async';
import 'package:MovieDemo/business_logic/database/database.dart';
import 'package:MovieDemo/business_logic/model/movie_favorite.dart';
import 'package:sqflite/sqflite.dart';

class MovieFavoriteDao {

  final dbProvider = DatabaseProvider.dbProvider;
  var tblName = tblMovieFavorite;

  static String getTableName(){
    return tblMovieFavorite;
  }

  //Add
  Future<int> create(MovieFavorite item) async {
    final db = await dbProvider.database;
    var result = await db.insert(tblName, item.toDatabaseJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  //Add List
  Future<List<dynamic>> createList(List<MovieFavorite> list) async {

    Batch batch;
    final db = await DatabaseProvider.dbProvider.database;
    batch = db.batch();
    for(MovieFavorite item in list){
      batch.insert(tblName, item.toDatabaseJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    List<dynamic> results = await batch.commit(continueOnError: true);
    return results;
  }



  Future<List<MovieFavorite>> getList({List<String>? columns, List<String>? arWhere, List<dynamic>? arWhereArgs, String? orderBy="id DESC",int? limit}) async {

    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    String where = "";
    List<dynamic> whereArgs = [];
    if (arWhere != null && whereArgs != null) {
      for(int i =0; i < arWhere.length; i++){
        if(i > 0) where += " AND ";
        where += arWhere[i];
      }
      for(int i =0; i < arWhereArgs!.length; i++){
        whereArgs.add(arWhereArgs[i]);
      }
      result = await db.query(tblName, columns: columns, where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit);

    } else {
      result = await db.query(tblName, columns: columns,orderBy: orderBy, limit: limit);
    }

    List<MovieFavorite> items = result.isNotEmpty
        ? result.map((item) => MovieFavorite.fromDatabaseJson(item)).toList()
        : [];
    return items;
  }

  //arWhere => ["title LIKE ?", "id = ?"]
  //arWhereArgs => ["%test%", 1]
  //orderBy: "id DESC"

  Future<List<MovieFavorite>> getListFilter({List<String>? columns, List<String>? arWhere, List<dynamic>? arWhereArgs, String orderBy="id DESC",int? limit}) async {


    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    String where = "";
    List<dynamic> whereArgs = [];
    if (arWhere != null && whereArgs != null) {
      for(int i =0; i < arWhere.length; i++){
        if(i > 0) where += " AND ";
        where += arWhere[i];
      }
      for(int i =0; i < arWhereArgs!.length; i++){
        whereArgs.add(arWhereArgs[i]);
      }
      result = await db.query(tblName, columns: columns, where: where, whereArgs: whereArgs, orderBy: orderBy,limit: limit);

    } else {
      result = await db.query(tblName, columns: columns,orderBy: orderBy,limit: limit);
    }

    List<MovieFavorite> items = result.isNotEmpty
        ? result.map((item) => MovieFavorite.fromDatabaseJson(item)).toList()
        : [];
    return items;
  }

  //Update
  Future<int> update(MovieFavorite item) async {
    final db = await dbProvider.database;

    var result = await db.update(tblName, item.toDatabaseJson(),
        where: "id = ?", whereArgs: [item.id]);

    return result;
  }

  //Update raw
  //arSet => [uid_mobi]
  //arWhere => ["id=?"]
  Future<int> updateRaw(List<String> arSet,  List<String> arWhere, List<dynamic> arguments)  async{
    final db = await dbProvider.database;

    String set = "";
    for(int i =0; i < arSet.length; i++){
      if(i > 0) set += " , ";
      set += arSet[i]+ "=?";
    }

    String where = "";
    for(int i =0; i < arWhere.length; i++){
      if(i > 0) where += " AND ";
      where += arWhere[i];
    }
    String query = "UPDATE " + tblName + " SET "  + set +" WHERE " + where;

    var result = await db.rawUpdate(query, arguments);
    return result;
  }


  //Delete records
  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(tblName, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<int> deleteByUserId(String userId) async {
    final db = await dbProvider.database;
    return await db.delete(tblName, where: 'userId = ?', whereArgs: [userId]);
  }

  Future<int> deleteByField(String fieldName, dynamic fieldValue) async {
    final db = await dbProvider.database;
    return await db.delete(tblName, where: '$fieldName = ?', whereArgs: [fieldValue]);
  }


  //We are not going to use this in the demo
  Future deleteAll() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      tblName,
    );
    return result;
  }

  //raw query
  Future rawQuery(String query, [List<dynamic>? arguments]) async{
    final db = await dbProvider.database;
    var result =  await db.rawQuery(query, arguments);
    return result;
  }

  Future<MovieFavorite?> getByField(String fieldName, dynamic value) async {

    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(tblName,
        where: '$fieldName = ?',
        whereArgs: [value]
    );

    if(result.isNotEmpty){
      List<MovieFavorite> items = result.map((item) => MovieFavorite.fromDatabaseJson(item)).toList();
      return items[0];
    }
    return null;
  }

  Future<MovieFavorite?> getById(String uid_mobi) async {

    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(tblName,
        where: 'uid_mobi = ?',
        whereArgs: [uid_mobi]
    );

    if(result.isNotEmpty){
      List<MovieFavorite> items = result.map((item) => MovieFavorite.fromDatabaseJson(item)).toList();
      return items[0];
    }
    return null;
  }

}
