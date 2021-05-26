import 'dart:async';

// required package imports
import 'package:floor/floor.dart';
import 'package:flutter_wanandroid/db/article_dao.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

/**
 * Run the generator with flutter packages pub run build_runner build.
 * To automatically run it, whenever a file changes,
 * use flutter packages pub run build_runner watch.
 */
///flutter packages pub run build_runner build
///flutter packages pub run build_runner watch
///手动修改
part "database.g.dart"; // the generated code will be there

@Database(version: 1, entities: [ArticleEntity])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}