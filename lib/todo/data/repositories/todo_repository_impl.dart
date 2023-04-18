import 'package:dartz/dartz.dart';
import '../../../common/error/exception.dart';
import '../../domain/entities/todo_data_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_data_source.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final ToDoRemoteDataSource remoteDataSource;

  ToDoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<APIException, List<TodoDataEntity>?>> toDoList(
    String? type,
    int page,
    int limit,
    String searchStr,
  ) async {
    final result =
        await remoteDataSource.toDoList(type, page, limit, searchStr);
    return result.fold((e) {
      return Left(e);
    }, (todoResponse) {
      return Right(todoResponse?.map((model) => model.toEntity()).toList());
    });
  }
}
