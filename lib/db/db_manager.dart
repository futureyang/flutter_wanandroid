import 'package:flutter_wanandroid/db/article_dao.dart';
import 'package:flutter_wanandroid/db/database.dart';

class DataBaseManager {
  AppDatabase database;

  DataBaseManager._privateConstructor() {
    var db = $FloorAppDatabase.databaseBuilder('wanandroid.db').build();
    db.then((value) {
      this.database = value;
    });
  }

  ArticleDao getArticleDao() => database.articleDao;

  static final DataBaseManager instance = DataBaseManager._privateConstructor();

  factory DataBaseManager() {
    return instance;
  }
}
