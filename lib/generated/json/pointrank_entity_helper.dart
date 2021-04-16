import 'package:flutter_wanandroid/entity/pointrank_entity.dart';

pointRankFromJson(PointRank data, Map<String, dynamic> json) {
	if (json['coinCount'] != null) {
		data.coinCount = json['coinCount'] is String
				? int.tryParse(json['coinCount'])
				: json['coinCount'].toInt();
	}
	if (json['level'] != null) {
		data.level = json['level'] is String
				? int.tryParse(json['level'])
				: json['level'].toInt();
	}
	if (json['rank'] != null) {
		data.rank = json['rank'] is String
				? int.tryParse(json['rank'])
				: json['rank'].toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	return data;
}

Map<String, dynamic> pointRankToJson(PointRank entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coinCount'] = entity.coinCount;
	data['level'] = entity.level;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}