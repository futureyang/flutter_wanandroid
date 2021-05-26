// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticleDao _articleDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `article` (`primaryKeyId` INTEGER, `apkLink` TEXT, `audit` INTEGER, `author` TEXT, `chapterId` INTEGER, `chapterName` TEXT, `collect` INTEGER, `courseId` INTEGER, `desc` TEXT, `envelopePic` TEXT, `fresh` INTEGER, `id` INTEGER, `link` TEXT, `niceDate` TEXT, `niceShareDate` TEXT, `origin` TEXT, `originId` INTEGER, `prefix` TEXT, `projectLink` TEXT, `publishTime` INTEGER, `selfVisible` INTEGER, `shareDate` INTEGER, `shareUser` TEXT, `superChapterId` INTEGER, `superChapterName` TEXT, `title` TEXT, `type` INTEGER, `userId` INTEGER, `visible` INTEGER, `zan` INTEGER, `top` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ArticleDao get articleDao {
    return _articleDaoInstance ??=
        _$ArticleDao(database, changeListener, QueryAdapter(database));
  }
}

class _$ArticleDao extends ArticleDao {
  _$ArticleDao(this.database, this.changeListener, this._queryAdapter)
      : _articleEntityInsertionAdapter = InsertionAdapter(
            database,
            'article',
            (ArticleEntity item) => <String, Object>{
                  'primaryKeyId': item.primaryKeyId,
                  'apkLink': item.apkLink,
                  'audit': item.audit,
                  'author': item.author,
                  'chapterId': item.chapterId,
                  'chapterName': item.chapterName,
                  'collect':
                      item.collect == null ? null : (item.collect ? 1 : 0),
                  'courseId': item.courseId,
                  'desc': item.desc,
                  'envelopePic': item.envelopePic,
                  'fresh': item.fresh == null ? null : (item.fresh ? 1 : 0),
                  'id': item.id,
                  'link': item.link,
                  'niceDate': item.niceDate,
                  'niceShareDate': item.niceShareDate,
                  'origin': item.origin,
                  'originId': item.originId,
                  'prefix': item.prefix,
                  'projectLink': item.projectLink,
                  'publishTime': item.publishTime,
                  'selfVisible': item.selfVisible,
                  'shareDate': item.shareDate,
                  'shareUser': item.shareUser,
                  'superChapterId': item.superChapterId,
                  'superChapterName': item.superChapterName,
                  'title': item.title,
                  'type': item.type,
                  'userId': item.userId,
                  'visible': item.visible,
                  'zan': item.zan,
                  'top': item.top == null ? null : (item.top ? 1 : 0)
                }),
        _articleEntityDeletionAdapter = DeletionAdapter(
            database,
            'article',
            ['id'],
            (ArticleEntity item) => <String, Object>{
                  'primaryKeyId': item.primaryKeyId,
                  'apkLink': item.apkLink,
                  'audit': item.audit,
                  'author': item.author,
                  'chapterId': item.chapterId,
                  'chapterName': item.chapterName,
                  'collect':
                      item.collect == null ? null : (item.collect ? 1 : 0),
                  'courseId': item.courseId,
                  'desc': item.desc,
                  'envelopePic': item.envelopePic,
                  'fresh': item.fresh == null ? null : (item.fresh ? 1 : 0),
                  'id': item.id,
                  'link': item.link,
                  'niceDate': item.niceDate,
                  'niceShareDate': item.niceShareDate,
                  'origin': item.origin,
                  'originId': item.originId,
                  'prefix': item.prefix,
                  'projectLink': item.projectLink,
                  'publishTime': item.publishTime,
                  'selfVisible': item.selfVisible,
                  'shareDate': item.shareDate,
                  'shareUser': item.shareUser,
                  'superChapterId': item.superChapterId,
                  'superChapterName': item.superChapterName,
                  'title': item.title,
                  'type': item.type,
                  'userId': item.userId,
                  'visible': item.visible,
                  'zan': item.zan,
                  'top': item.top == null ? null : (item.top ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ArticleEntity> _articleEntityInsertionAdapter;

  final DeletionAdapter<ArticleEntity> _articleEntityDeletionAdapter;

  @override
  Future<List<ArticleEntity>> findAllArticles() async {
    return _queryAdapter.queryList(
        'SELECT * FROM article order by rowid desc limit 50',
        mapper: (Map<String, dynamic> row) => ArticleEntity(
              apkLink: row['apkLink'] as String,
              audit: row['audit'] as int,
              author: row['author'] as String,
              chapterId: row['chapterId'] as int,
              chapterName: row['chapterName'] as String,
              collect: row['collect'] == 1 ? true : false,
              courseId: row['courseId'] as int,
              desc: row['desc'] as String,
              envelopePic: row['envelopePic'] as String,
              fresh: row['fresh'] == 1 ? true : false,
              id: row['id'] as int,
              link: row['link'] as String,
              niceDate: row['niceDate'] as String,
              niceShareDate: row['niceShareDate'] as String,
              origin: row['origin'] as String,
              prefix: row['prefix'] as String,
              projectLink: row['projectLink'] as String,
              publishTime: row['publishTime'] as int,
              selfVisible: row['selfVisible'] as int,
              shareDate: row['shareDate'] as int,
              shareUser: row['shareUser'] as String,
              superChapterId: row['superChapterId'] as int,
              superChapterName: row['superChapterName'] as String,
              title: row['title'] as String,
              type: row['type'] as int,
              userId: row['userId'] as int,
              visible: row['visible'] as int,
              zan: row['zan'] as int,
            ));
  }

  @override
  Future<void> insertArticle(ArticleEntity article) async {
    await _articleEntityInsertionAdapter.insert(
        article, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) async {
    await _articleEntityDeletionAdapter.delete(article);
  }
}
