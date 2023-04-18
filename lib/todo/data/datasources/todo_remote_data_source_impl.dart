import 'package:dartz/dartz.dart';

import '../../../common/api_manager.dart';
import '../../../common/error/exception.dart';
import '../models/todo_data.dart';
import '../models/todo_response.dart';
import 'todo_remote_data_source.dart';

class ToDoRemoteDataSourceImpl implements ToDoRemoteDataSource {
  final APIManager apiManager;

  ToDoRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<APIException, List<TodoDataModel>?>> toDoList(
    String? type,
    int page,
    int limit,
    String searchStr,
  ) async {
    Map<dynamic, dynamic> requestDict = {};
    // requestDict["type"] = type;
    requestDict["_page"] = page;
    requestDict["_limit"] = limit;
    // requestDict["search_str"] = searchStr;

    try {
      final response = await apiManager.request("posts",
          data: requestDict, method: APIMethod.get);
      var data = List<TodoDataModel>.from(
          (response.data as List).map((x) => TodoDataModel.fromJson(x)));
      return Right(data);
    } on APIException catch (e) {
      return left(e);
    }
  }
}
