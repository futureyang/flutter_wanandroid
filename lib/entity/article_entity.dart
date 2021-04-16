import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class ArticleList with JsonConvert<ArticleList>{
  int offset = 0;
  int size = 0;
  int total = 0;
  int pageCount = 0;
  int curPage = 0;
  bool over = false;
  List<Article> datas = <Article>[];
}

class Article with JsonConvert<Article> {
  int primaryKeyId = 0;
  String apkLink = "";
  int audit = 0;
  String author = ""; //作者
  int chapterId = 0;
  String chapterName = ""; //章节名
  bool collect = false; //收藏
  int courseId = 0; //课程id
  String desc = "";
  String envelopePic = "";
  bool fresh = false; //新的
  int id = 0;
  String link = ""; //文章地址
  String niceDate = "";
  String niceShareDate = "";
  String origin = "";
  int originId = 0;
  String prefix = "";
  String projectLink = "";
  int publishTime = 0;
  int selfVisible = 0;
  int shareDate = 0;
  String shareUser = ""; //分享人
  int superChapterId = 0; //顶级章节id
  String superChapterName = ""; //顶级章节
  List<Tag> tags = <Tag>[];
  String title = ""; //文章标题
  int type = 0;
  int userId = 0;
  int visible = 0; //可见
  int zan = 0;
  bool top = false; //置顶
}

class Tag with JsonConvert<Tag> {
  int id = 0;
  int articleId = 0;
  String name = "";
  String url = "";
}
