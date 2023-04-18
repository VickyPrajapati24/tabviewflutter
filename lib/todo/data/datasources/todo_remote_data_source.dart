import 'package:dartz/dartz.dart';
import '../../../common/error/exception.dart';
import '../models/todo_data.dart';
import '../models/todo_response.dart';

abstract class ToDoRemoteDataSource {
  Future<Either<APIException, List<TodoDataModel>?>> toDoList(
    String? type,
    int page,
    int limit,
    String searchStr,
  );
}
