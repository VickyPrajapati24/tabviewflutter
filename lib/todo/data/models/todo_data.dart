import 'package:equatable/equatable.dart';

import '../../domain/entities/todo_data_entity.dart';

class TodoDataModel extends Equatable {
  final int? userId;
  final int? id;
  final String? title;

  const TodoDataModel({
    this.userId,
    this.id,
    this.title,
  });

  factory TodoDataModel.fromJson(Map<String, dynamic> json) {
    return TodoDataModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
    };
  }

  TodoDataEntity toEntity() {
    return TodoDataEntity(
      userId: userId,
      id: id,
      title: title,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
      ];
}
