import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class PointRankList with JsonConvert<PointRankList> {
  int offset = 0;
  int size = 0;
  int total = 0;
  int pageCount = 0;
  int curPage = 0;
  bool over = false;
  List<PointRank> datas = <PointRank>[];
}

class PointRank with JsonConvert<PointRank> {
  int coinCount = 0;
  int level = 0;
  int rank = 0;
  int userId = 0;
  String username = "";
}
