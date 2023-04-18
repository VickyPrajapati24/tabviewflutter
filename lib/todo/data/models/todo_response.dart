import 'package:equatable/equatable.dart';
import 'todo_data.dart';

class TodoResponse extends Equatable {
  final String? message;
  final List<TodoDataModel>? data;

  const TodoResponse({
    this.message,
    this.data,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) {
    var data = List<TodoDataModel>.from(
        (json["data"] as List).map((x) => TodoDataModel.fromJson(x)));
    return TodoResponse(
      message: json["message"],
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data,
    };
  }

  @override
  List<Object?> get props => [message, data];
}
