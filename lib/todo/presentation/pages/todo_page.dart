import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/todo_data_entity.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/todo_cell_widget.dart';

enum ToDoTypeEnum {
  page1,
  page2,
  page3,
  page4,
}

extension ToDoTypeStr on ToDoTypeEnum {
  String get rawValue {
    switch (this) {
      case ToDoTypeEnum.page1:
        return '1';
      case ToDoTypeEnum.page2:
        return '2';
      case ToDoTypeEnum.page3:
        return '3';
      case ToDoTypeEnum.page4:
        return '4';
    }
  }
}

class ToDoPage extends StatefulWidget {
  const ToDoPage({
    super.key,
    this.objToDoTypeEnum,
    this.searchText,
  });

  final ToDoTypeEnum? objToDoTypeEnum;
  final String? searchText;

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState
    extends State<ToDoPage> /*with AutomaticKeepAliveClientMixin<ToDoPage>*/ {
  ToDoTypeEnum? get objToDoTypeEnum => widget.objToDoTypeEnum;
  String? get searchText => widget.searchText;

  @override
  initState() {
    super.initState();

    fetchToDo();
  }

  @override
  void dispose() {
    // BlocProvider.of<TodoListBloc>(context).close();
    super.dispose();
  }

  @override
  deactivate() {
    super.deactivate();
  }

  List<TodoDataEntity>? arrTodoDataEntity;

  void fetchToDo() {
    Future.microtask(
      () => BlocProvider.of<TodoListBloc>(
        context,
        listen: false,
      ).add(
        TodoListUser(objToDoTypeEnum.toString(), 1, 10, searchText ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return BlocBuilder<TodoListBloc, TodoListState>(builder: (context, state) {
      debugPrint("XXXXXX API response state: $state");

      if (state is TodoListInProgress) {
        EasyLoading.show(status: 'Fetching To Do...');
      } else if (state is TodoListCallSuccess) {
        EasyLoading.dismiss();
        arrTodoDataEntity = state.arrTodoDataEntity ?? [];
        return Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                itemCount: arrTodoDataEntity?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ToDoCell(
                    objTodoDataEntity: arrTodoDataEntity?[index],
                    onCardClick: () {},
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      } else if (state is TodoListCallFailed) {
        EasyLoading.dismiss();
      }
      return Container();
    });
  }
}
