import 'package:floor/floor.dart';

@Entity(tableName : "article")
class ArticleHistory{
  @PrimaryKey(autoGenerate: true)
  final int primaryKeyId;
  final String author; //作者
  final int id;
  final String link; //文章地址
  final String shareUser; //分享人
  final String title; //文章标题

  ArticleHistory(this.primaryKeyId, this.author, this.id, this.link,
      this.shareUser, this.title);
}