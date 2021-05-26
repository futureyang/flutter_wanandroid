// entity/person.dart

import 'package:floor/floor.dart';

@Entity(tableName : "search")
class SearchEntity {
  @PrimaryKey(autoGenerate: true)
  int id;
  String type;
  String value;

  SearchEntity({this.id, this.type, this.value});
}