import 'package:flutter_wanandroid/entity/hotword_entity.dart';

hotWordFromJson(HotWord data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['link'] != null) {
		data.link = json['link'].toString();
	}
	if (json['order'] != null) {
		data.order = json['order'] is String
				? int.tryParse(json['order'])
				: json['order'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['visible'] != null) {
		data.visible = json['visible'] is String
				? int.tryParse(json['visible'])
				: json['visible'].toInt();
	}
	return data;
}

Map<String, dynamic> hotWordToJson(HotWord entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['order'] = entity.order;
	data['name'] = entity.name;
	data['visible'] = entity.visible;
	return data;
}