import 'package:flutter_wanandroid/entity/pointrecord_entity.dart';

pointRecordListFromJson(PointRecordList data, Map<String, dynamic> json) {
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
		data.datas = (json['datas'] as List).map((v) => PointRecord().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> pointRecordListToJson(PointRecordList entity) {
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

pointRecordFromJson(PointRecord data, Map<String, dynamic> json) {
	if (json['coinCount'] != null) {
		data.coinCount = json['coinCount'] is String
				? int.tryParse(json['coinCount'])
				: json['coinCount'].toInt();
	}
	if (json['date'] != null) {
		data.date = json['date'] is String
				? int.tryParse(json['date'])
				: json['date'].toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['reason'] != null) {
		data.reason = json['reason'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'] is String
				? int.tryParse(json['type'])
				: json['type'].toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	return data;
}

Map<String, dynamic> pointRecordToJson(PointRecord entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coinCount'] = entity.coinCount;
	data['date'] = entity.date;
	data['desc'] = entity.desc;
	data['id'] = entity.id;
	data['reason'] = entity.reason;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['userName'] = entity.userName;
	return data;
}