part of 'todo_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object?> get props => [];
}

class TodoListUser extends TodoListEvent {
  final String type;
  final int page;
  final int limit;
  final String searchStr;

  const TodoListUser(this.type, this.page, this.limit, this.searchStr);

  @override
  List<Object?> get props => [
        type,
        page,
        limit,
        searchStr,
      ];
}
