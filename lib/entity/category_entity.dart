import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class Category with JsonConvert<Category> {
  int courseId = 0;
  int id = 0;
  String name = "";
  int order = 0;
  int parentChapterId = 0;
  bool userControlSetTop = false;
  int visible = 0;
  List<Category> children;
}