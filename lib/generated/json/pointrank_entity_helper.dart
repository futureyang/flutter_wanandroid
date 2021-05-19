import 'package:flutter_wanandroid/entity/pointrank_entity.dart';

pointRankListFromJson(PointRankList data, Map<String, dynamic> json) {
	if (json['offset'] != null) {
		data.offset = json['offset'] is String
				? int.tryParse(json['offset'])
				: json['offset'].toInt();
	}
	if (json['size'] != null) {
		data.size = json['size'] is String
				? int.tryParse(json['size'])
				: json['size'].toInt();
	}
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	if (json['pageCount'] != null) {
		data.pageCount = json['pageCount'] is String
				? int.tryParse(json['pageCount'])
				: json['pageCount'].toInt();
	}
	if (json['curPage'] != null) {
		data.curPage = json['curPage'] is String
				? int.tryParse(json['curPage'])
				: json['curPage'].toInt();
	}
	if (json['over'] != null) {
		data.over = json['over'];
	}
	if (json['datas'] != null) {
		data.datas = (json['datas'] as List).map((v) => PointRank().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> pointRankListToJson(PointRankList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['offset'] = entity.offset;
	data['size'] = entity.size;
	data['total'] = entity.total;
	data['pageCount'] = entity.pageCount;
	data['curPage'] = entity.curPage;
	data['over'] = entity.over;
	data['datas'] =  entity.datas?.map((v) => v.toJson())?.toList();
	return data;
}

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