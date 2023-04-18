import 'package:dartz/dartz.dart';
import '../../../common/error/exception.dart';
import '../entities/todo_data_entity.dart';

abstract class ToDoRepository {
  Future<Either<APIException, List<TodoDataEntity>?>> toDoList(
    String? type,
    int page,
    int limit,
    String searchStr,
  );
}
