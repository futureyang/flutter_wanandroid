import 'entity_factory.dart';

class HttpResult<T> {
  int state;
  String message;
  T data;

  HttpResult({this.state, this.message, this.data});

  factory HttpResult.fromJson(state, message, data, json) {
    return HttpResult(
        state: json[state],
        message: json[message],
        // data值需要经过工厂转换为我们传进来的类型
        data: EntityFactory.generateOBJ<T>(json[data]));
  }
}
