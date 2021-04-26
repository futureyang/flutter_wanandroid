// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_wanandroid/entity/pointrank_entity.dart';
import 'package:flutter_wanandroid/generated/json/pointrank_entity_helper.dart';
import 'package:flutter_wanandroid/entity/navigation_entity.dart';
import 'package:flutter_wanandroid/generated/json/navigation_entity_helper.dart';
import 'package:flutter_wanandroid/entity/banner_entity.dart';
import 'package:flutter_wanandroid/generated/json/banner_entity_helper.dart';
import 'package:flutter_wanandroid/entity/category_entity.dart';
import 'package:flutter_wanandroid/generated/json/category_entity_helper.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';
import 'package:flutter_wanandroid/generated/json/article_entity_helper.dart';
import 'package:flutter_wanandroid/entity/pointrecord_entity.dart';
import 'package:flutter_wanandroid/generated/json/pointrecord_entity_helper.dart';
import 'package:flutter_wanandroid/entity/userinfo_entity.dart';
import 'package:flutter_wanandroid/generated/json/userinfo_entity_helper.dart';
import 'package:flutter_wanandroid/entity/hotword_entity.dart';
import 'package:flutter_wanandroid/generated/json/hotword_entity_helper.dart';
import 'package:flutter_wanandroid/entity/shard_entity.dart';
import 'package:flutter_wanandroid/generated/json/shard_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case PointRank:
				return pointRankFromJson(data as PointRank, json) as T;
			case Navigation:
				return navigationFromJson(data as Navigation, json) as T;
			case Banner:
				return bannerFromJson(data as Banner, json) as T;
			case Category:
				return categoryFromJson(data as Category, json) as T;
			case ArticleList:
				return articleListFromJson(data as ArticleList, json) as T;
			case Article:
				return articleFromJson(data as Article, json) as T;
			case Tag:
				return tagFromJson(data as Tag, json) as T;
			case PointRecordList:
				return pointRecordListFromJson(data as PointRecordList, json) as T;
			case PointRecord:
				return pointRecordFromJson(data as PointRecord, json) as T;
			case UserInfo:
				return userInfoFromJson(data as UserInfo, json) as T;
			case HotWord:
				return hotWordFromJson(data as HotWord, json) as T;
			case Shard:
				return shardFromJson(data as Shard, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case PointRank:
				return pointRankToJson(data as PointRank);
			case Navigation:
				return navigationToJson(data as Navigation);
			case Banner:
				return bannerToJson(data as Banner);
			case Category:
				return categoryToJson(data as Category);
			case ArticleList:
				return articleListToJson(data as ArticleList);
			case Article:
				return articleToJson(data as Article);
			case Tag:
				return tagToJson(data as Tag);
			case PointRecordList:
				return pointRecordListToJson(data as PointRecordList);
			case PointRecord:
				return pointRecordToJson(data as PointRecord);
			case UserInfo:
				return userInfoToJson(data as UserInfo);
			case HotWord:
				return hotWordToJson(data as HotWord);
			case Shard:
				return shardToJson(data as Shard);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (PointRank).toString()){
			return PointRank().fromJson(json);
		}	else if(type == (Navigation).toString()){
			return Navigation().fromJson(json);
		}	else if(type == (Banner).toString()){
			return Banner().fromJson(json);
		}	else if(type == (Category).toString()){
			return Category().fromJson(json);
		}	else if(type == (ArticleList).toString()){
			return ArticleList().fromJson(json);
		}	else if(type == (Article).toString()){
			return Article().fromJson(json);
		}	else if(type == (Tag).toString()){
			return Tag().fromJson(json);
		}	else if(type == (PointRecordList).toString()){
			return PointRecordList().fromJson(json);
		}	else if(type == (PointRecord).toString()){
			return PointRecord().fromJson(json);
		}	else if(type == (UserInfo).toString()){
			return UserInfo().fromJson(json);
		}	else if(type == (HotWord).toString()){
			return HotWord().fromJson(json);
		}	else if(type == (Shard).toString()){
			return Shard().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<PointRank>[] is M){
			return data.map<PointRank>((e) => PointRank().fromJson(e)).toList() as M;
		}	else if(<Navigation>[] is M){
			return data.map<Navigation>((e) => Navigation().fromJson(e)).toList() as M;
		}	else if(<Banner>[] is M){
			return data.map<Banner>((e) => Banner().fromJson(e)).toList() as M;
		}	else if(<Category>[] is M){
			return data.map<Category>((e) => Category().fromJson(e)).toList() as M;
		}	else if(<ArticleList>[] is M){
			return data.map<ArticleList>((e) => ArticleList().fromJson(e)).toList() as M;
		}	else if(<Article>[] is M){
			return data.map<Article>((e) => Article().fromJson(e)).toList() as M;
		}	else if(<Tag>[] is M){
			return data.map<Tag>((e) => Tag().fromJson(e)).toList() as M;
		}	else if(<PointRecordList>[] is M){
			return data.map<PointRecordList>((e) => PointRecordList().fromJson(e)).toList() as M;
		}	else if(<PointRecord>[] is M){
			return data.map<PointRecord>((e) => PointRecord().fromJson(e)).toList() as M;
		}	else if(<UserInfo>[] is M){
			return data.map<UserInfo>((e) => UserInfo().fromJson(e)).toList() as M;
		}	else if(<HotWord>[] is M){
			return data.map<HotWord>((e) => HotWord().fromJson(e)).toList() as M;
		}	else if(<Shard>[] is M){
			return data.map<Shard>((e) => Shard().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}