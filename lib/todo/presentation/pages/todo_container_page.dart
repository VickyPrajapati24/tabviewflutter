import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/todo_bloc.dart';
import 'todo_page.dart';

class ToDoContainerPage extends StatefulWidget {
  const ToDoContainerPage({super.key});

  @override
  State<ToDoContainerPage> createState() => _ToDoContainerPageState();
}

class _ToDoContainerPageState extends State<ToDoContainerPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  late TabController _tabController;
  String searchText = '';

  @override
  initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      // setState(() {});
      // print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  deactivate() {
    super.deactivate();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(width: 10),
                  Text(
                    'TO DO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
                onSubmitted: (value) {
                  searchText = value;
                  // CALL API TO REFRESH CURRENT PAGE WITH UPDATED SEARCH TEXT
                },
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0)),
                child: TabBar(
                  isScrollable: true,
                  indicator: BoxDecoration(
                      color: const Color.fromRGBO(89, 147, 189, 1),
                      borderRadius: BorderRadius.circular(20.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: "Page 1",
                    ),
                    Tab(
                      text: 'Page 2',
                    ),
                    Tab(
                      text: 'Page 3',
                    ),
                    Tab(
                      text: 'Page 4',
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                // key: UniqueKey(),
                children: [
                  BlocProvider<TodoListBloc>(
                    create: (_) => TodoListBloc(locator()),
                    child: ToDoPage(
                      objToDoTypeEnum: ToDoTypeEnum.page1,
                      searchText: searchText,
                    ),
                  ),
                  BlocProvider<TodoListBloc>(
                    create: (_) => TodoListBloc(locator()),
                    child: ToDoPage(
                      objToDoTypeEnum: ToDoTypeEnum.page2,
                      searchText: searchText,
                    ),
                  ),
                  BlocProvider<TodoListBloc>(
                    create: (_) => TodoListBloc(locator()),
                    child: ToDoPage(
                      objToDoTypeEnum: ToDoTypeEnum.page3,
                      searchText: searchText,
                    ),
                  ),
                  BlocProvider<TodoListBloc>(
                    create: (_) => TodoListBloc(locator()),
                    child: ToDoPage(
                      objToDoTypeEnum: ToDoTypeEnum.page4,
                      searchText: searchText,
                    ),
                  ),
                ],
              )),
            ],
          ),
        )),
      ),
    );
  }
}
