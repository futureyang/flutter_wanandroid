import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class Navigation with JsonConvert<Navigation> {
  int cid = 0;
  String name = "";
  List<Article> articles;
}