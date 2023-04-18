import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/error/exception.dart';
import '../../domain/entities/todo_data_entity.dart';
import '../../domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final TodoUseCase todoUseCase;

  TodoListBloc(this.todoUseCase) : super(TodoListInitial()) {
    on<TodoListUser>((event, emit) async {
      final type = event.type;
      final page = event.page;
      final limit = event.limit;
      final searchStr = event.searchStr;
      emit(TodoListInProgress());
      final result = await todoUseCase.toDoList(type, page, limit, searchStr);
      result
          .fold((failure) => emit(TodoListCallFailed(objAPIException: failure)),
              (arrTodoDataEntity) {
        emit(TodoListCallSuccess(arrTodoDataEntity: arrTodoDataEntity));
      });
    });
  }
}
