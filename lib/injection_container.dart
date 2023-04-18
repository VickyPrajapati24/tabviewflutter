import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'common/api_manager.dart';
import 'todo/data/datasources/todo_remote_data_source.dart';
import 'todo/data/datasources/todo_remote_data_source_impl.dart';
import 'todo/data/repositories/todo_repository_impl.dart';
import 'todo/domain/repositories/todo_repository.dart';
import 'todo/domain/usecases/todo_usecase.dart';
import 'todo/presentation/bloc/todo_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //bloc
  locator.registerFactory(
    () => TodoListBloc(
      locator(),
    ),
  );

  // // Use Cases
  locator.registerLazySingleton(() => TodoUseCase(locator()));

  locator.registerLazySingleton<http.Client>(() => http.Client());
  locator
      .registerLazySingleton<APIManager>(() => APIManager(client: locator()));

  // // Repository
  locator.registerLazySingleton<ToDoRepository>(
    () => ToDoRepositoryImpl(remoteDataSource: locator()),
  );

  // // Remote Data Source
  locator.registerLazySingleton<ToDoRemoteDataSource>(
    () => ToDoRemoteDataSourceImpl(apiManager: locator()),
  );
}
