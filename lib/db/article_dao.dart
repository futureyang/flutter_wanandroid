import 'package:floor/floor.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';

@dao
abstract class ArticleDao{

  /// insert into <表名> [列名] values <列值>
  /// delete from <表名> [where <删除条件>]　　
  /// update <表名> set <列名=更新值> [where <更新条件>]
  /// select <列名> from <表名> [where <查询条件表达试>] [order by <排序的列名>[asc或desc]]

  @Query('SELECT * FROM article order by rowid desc limit 50')
  Future<List<ArticleEntity>> findAllArticles();

  @insert
  Future<void> insertArticle(ArticleEntity article);

  @delete
  Future<void> deleteArticle(ArticleEntity article);

//  @update
//  Future<List<int>> updateSearch(List<SearchEntity> searchs);
}