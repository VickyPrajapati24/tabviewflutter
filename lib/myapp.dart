import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tabview/todo/presentation/pages/todo_container_page.dart';
import 'package:tabview/todo/presentation/pages/todo_page.dart';
import '../../on_generate_route.dart';
import '../../injection_container.dart' as di;
import 'todo/presentation/bloc/todo_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<TodoListBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "app",
        // darkTheme: ThemeData.dark(),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: "/",
        routes: {
          "/": (context) {
            return const ToDoContainerPage();
          }
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
