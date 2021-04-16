import 'package:flutter_wanandroid/entity/category_entity.dart';

categoryFromJson(Category data, Map<String, dynamic> json) {
	if (json['courseId'] != null) {
		data.courseId = json['courseId'] is String
				? int.tryParse(json['courseId'])
				: json['courseId'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['order'] != null) {
		data.order = json['order'] is String
				? int.tryParse(json['order'])
				: json['order'].toInt();
	}
	if (json['parentChapterId'] != null) {
		data.parentChapterId = json['parentChapterId'] is String
				? int.tryParse(json['parentChapterId'])
				: json['parentChapterId'].toInt();
	}
	if (json['userControlSetTop'] != null) {
		data.userControlSetTop = json['userControlSetTop'];
	}
	if (json['visible'] != null) {
		data.visible = json['visible'] is String
				? int.tryParse(json['visible'])
				: json['visible'].toInt();
	}
	if (json['children'] != null) {
		data.children = (json['children'] as List).map((v) => Category().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> categoryToJson(Category entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['courseId'] = entity.courseId;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['parentChapterId'] = entity.parentChapterId;
	data['userControlSetTop'] = entity.userControlSetTop;
	data['visible'] = entity.visible;
	data['children'] =  entity.children?.map((v) => v.toJson())?.toList();
	return data;
}