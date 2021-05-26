import 'package:floor/floor.dart';
import 'package:flutter_wanandroid/entity/pointrank_entity.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class ArticleList with JsonConvert<ArticleList> {
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

@Entity(tableName: 'Tag')
class Tag with JsonConvert<Tag> {
  @PrimaryKey(autoGenerate: true)
  int id = 0;
  @ColumnInfo(name: "article_id")
  int articleId = 0;
  String name = "";
  String url = "";
}

class ShareArticleList with JsonConvert<ShareArticleList> {
  PointRank coinInfo;
  ArticleList shareArticles;
}

@Entity(tableName: 'article')
class ArticleEntity {
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
  @PrimaryKey()
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
  @ignore
  List<Tag> tags = <Tag>[];
  String title = ""; //文章标题
  int type = 0;
  int userId = 0;
  int visible = 0; //可见
  int zan = 0;
  bool top = false;

  ArticleEntity({
      this.primaryKeyId,
      this.apkLink,
      this.audit,
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.niceShareDate,
      this.origin,
      this.originId,
      this.prefix,
      this.projectLink,
      this.publishTime,
      this.selfVisible,
      this.shareDate,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan,
      this.top}); //置顶

  ArticleEntity.fromJson(Map<String, dynamic> json) {
    apkLink = json['apkLink'];
    audit = json['audit'];
    author = json['author'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    collect = json['collect'];
    courseId = json['courseId'];
    desc = json['desc'];
    envelopePic = json['envelopePic'];
    fresh = json['fresh'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    niceShareDate = json['niceShareDate'];
    origin = json['origin'];
    prefix = json['prefix'];
    projectLink = json['projectLink'];
    publishTime = json['publishTime'];
    selfVisible = json['selfVisible'];
    shareDate = json['shareDate'];
    shareUser = json['shareUser'];
    superChapterId = json['superChapterId'];
    superChapterName = json['superChapterName'];
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apkLink'] = this.apkLink;
    data['audit'] = this.audit;
    data['author'] = this.author;
    data['chapterId'] = this.chapterId;
    data['chapterName'] = this.chapterName;
    data['collect'] = this.collect;
    data['courseId'] = this.courseId;
    data['desc'] = this.desc;
    data['envelopePic'] = this.envelopePic;
    data['fresh'] = this.fresh;
    data['id'] = this.id;
    data['link'] = this.link;
    data['niceDate'] = this.niceDate;
    data['niceShareDate'] = this.niceShareDate;
    data['origin'] = this.origin;
    data['prefix'] = this.prefix;
    data['projectLink'] = this.projectLink;
    data['publishTime'] = this.publishTime;
    data['selfVisible'] = this.selfVisible;
    data['shareDate'] = this.shareDate;
    data['shareUser'] = this.shareUser;
    data['superChapterId'] = this.superChapterId;
    data['superChapterName'] = this.superChapterName;
    data['title'] = this.title;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['visible'] = this.visible;
    data['zan'] = this.zan;
    return data;
  }
}
