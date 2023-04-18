import 'package:dartz/dartz.dart';
import '../../../common/error/exception.dart';
import '../entities/todo_data_entity.dart';
import '../repositories/todo_repository.dart';

class TodoUseCase {
  final ToDoRepository repository;

  TodoUseCase(this.repository);

  Future<Either<APIException, List<TodoDataEntity>?>> toDoList(
      String? type, int page, int limit, String searchStr) {
    return repository.toDoList(type, page, limit, searchStr);
  }
}
