import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String? message;

  const TodoEntity({this.message});

  @override
  List<Object?> get props => [message];
}
