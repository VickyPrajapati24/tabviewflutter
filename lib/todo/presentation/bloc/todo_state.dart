part of 'todo_bloc.dart';

abstract class TodoListState extends Equatable {
  const TodoListState();

  @override
  List<Object> get props => [];
}

class TodoListInitial extends TodoListState {
  @override
  List<Object> get props => [];
}

class TodoListInProgress extends TodoListState {
  @override
  List<Object> get props => [];
}

class TodoListCallSuccess extends TodoListState {
  final List<TodoDataEntity>? arrTodoDataEntity;

  const TodoListCallSuccess({required this.arrTodoDataEntity});

  @override
  List<Object> get props => [List<TodoDataEntity>];
}

class TodoListCallFailed extends TodoListState {
  final APIException? objAPIException;

  const TodoListCallFailed({required this.objAPIException});

  @override
  List<Object> get props => [APIException];
}
