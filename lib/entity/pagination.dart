import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class Pagination<T> {
  int offset = 0;
  int size = 0;
  int total = 0;
  int pageCount = 0;
  int curPage = 0;
  bool over = false;
  List<T> datas = <T>[];


  Pagination({this.offset, this.size, this.total, this.pageCount, this.curPage,
      this.over, this.datas});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      offset: json['offset'],
      size: json['size'],
      total: json['total'],
      pageCount: json['pageCount'],
      curPage: json['curPage'],
      over: json['over'],
      datas: json['datas'],
    );
  }

}