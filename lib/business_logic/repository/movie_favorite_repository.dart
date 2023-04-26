

import 'package:MovieDemo/business_logic/dao/movie_favorite_dao.dart';
import 'package:MovieDemo/business_logic/model/movie_favorite.dart';

class MovieFavoriteRepository {

  final itemDao = MovieFavoriteDao();

  Future getList(
      {List<String>? arWhere, List<dynamic>? arWhereArgs, String? orderBy,int? limit}) =>
      itemDao.getList(arWhere: arWhere, arWhereArgs: arWhereArgs, orderBy: orderBy,limit: limit);

  Future getListFilter({List<String>? columns, List<String>? arWhere, List<dynamic>? arWhereArgs, String orderBy = "id DESC", int? limit}) =>
      itemDao.getListFilter(columns: columns,
          arWhere: arWhere,
          arWhereArgs: arWhereArgs,
          orderBy: orderBy,
          limit: limit
      );


  Future insert(MovieFavorite item) async {
    await itemDao.create(item);
  }

  Future insertList(List<MovieFavorite> list) async {
    return await itemDao.createList(list);
  }


  Future update(MovieFavorite item) => itemDao.update(item);

  Future updateRaw(List<String> arSet, List<String> arWhere,
      List<dynamic> arguments) => itemDao.updateRaw(arSet, arWhere, arguments);



  Future deleteByField(String fieldName, dynamic fieldValue) async {
    return await itemDao.deleteByField(fieldName, fieldValue);
  }


  Future deleteById(int id) => itemDao.delete(id);
  Future<MovieFavorite?> getByField(String fieldName, dynamic value) => itemDao.getByField(fieldName,value);

  //We are not going to use this in the demo
  Future deleteAll()  async => await  itemDao.deleteAll();

  //raw query
  Future rawQuery(String query, [List<dynamic>? arguments]) async {
    return await itemDao.rawQuery(query, arguments);
  }

}