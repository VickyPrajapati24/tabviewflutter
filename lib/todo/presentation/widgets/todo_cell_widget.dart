import 'package:flutter/material.dart';
import '../../domain/entities/todo_data_entity.dart';

class ToDoCell extends StatefulWidget {
  final TodoDataEntity? objTodoDataEntity;

  final void Function() onCardClick;

  const ToDoCell(
      {super.key, required this.objTodoDataEntity, required this.onCardClick});

  @override
  State<ToDoCell> createState() => _DashboardCellState();
}

class _DashboardCellState extends State<ToDoCell> {
  TodoDataEntity? get objTodoDataEntity => widget.objTodoDataEntity;

  void Function() get onCardClick => widget.onCardClick;

  // String? followUpDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      shadowColor: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '${objTodoDataEntity?.title}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
