import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class PointRecordList with JsonConvert<PointRecordList> {
  int offset = 0;
  int size = 0;
  int total = 0;
  int pageCount = 0;
  int curPage = 0;
  bool over = false;
  List<PointRecord> datas = <PointRecord>[];
}

class PointRecord with JsonConvert<PointRecord> {
  int coinCount = 0;
  int date = 0;
  String desc = "";
  int id = 0;
  String reason = "";
  int type = 0;
  int userId = 0;
  String userName = "";
}