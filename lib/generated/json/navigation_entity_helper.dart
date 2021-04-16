import 'package:flutter_wanandroid/entity/navigation_entity.dart';
import 'package:flutter_wanandroid/entity/article_entity.dart';

navigationFromJson(Navigation data, Map<String, dynamic> json) {
	if (json['cid'] != null) {
		data.cid = json['cid'] is String
				? int.tryParse(json['cid'])
				: json['cid'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['articles'] != null) {
		data.articles = (json['articles'] as List).map((v) => Article().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> navigationToJson(Navigation entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cid'] = entity.cid;
	data['name'] = entity.name;
	data['articles'] =  entity.articles?.map((v) => v.toJson())?.toList();
	return data;
}