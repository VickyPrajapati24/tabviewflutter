import 'package:equatable/equatable.dart';

class TodoDataEntity extends Equatable {
  final int? userId;
  final int? id;
  final String? title;

  const TodoDataEntity({
    this.userId,
    this.id,
    this.title,
  });

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
      ];
}
