import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloc/data/repo/repository.dart';
import 'package:todo_bloc/extention.dart';
import 'package:todo_bloc/screens/edit/edit.dart';
import 'package:todo_bloc/screens/home/bloc/task_list_bloc.dart';
import 'package:todo_bloc/widgets.dart';
import '../../data/data.dart';
import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextEditingController controller = TextEditingController();
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: addNewTaskButton(context),
        body: BlocProvider<TaskListBloc>(
          create: (context) =>
              TaskListBloc(context.read<Repository<TaskEntity>>()),
          child: _body(themeData, controller),
        ));
  }

  Widget _body(ThemeData themeData, TextEditingController controller) {
    return SafeArea(
      child: Column(
        children: [
          appBarHomeScreen(themeData, controller),
          Expanded(
              child: Consumer<Repository<TaskEntity>>(
            builder: (context, model, child) {
              context.read<TaskListBloc>().add(TaskListStarted());
              return BlocBuilder<TaskListBloc, TaskListState>(
                builder: (context, state) {
                  if (state is TaskListSuccess) {
                    return taskList(state.items, themeData);
                  } else if (state is TaskListEmpty) {
                    return emptyList();
                  } else if (state is TaskListLoading ||
                      state is TaskListInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TaskListError) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else {
                    throw Exception('state is not valid...');
                  }
                },
              );
            }
          )),
        ],
      ),
    );
  }

  Widget taskList(List<TaskEntity> items, ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Today',
                      style: themeData.textTheme.headline6!
                          .apply(fontSizeFactor: 0.9),
                    ),
                    Container(
                      height: 3.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.5),
                          color: themeData.primaryColor),
                    )
                  ],
                ),
                deleteAllTaskButton()
              ],
            );
          } else {
            final TaskEntity task = items[index - 1];
            return manageTask(context, task, themeData);
          }
        },
      ),
    );
  }

  Widget addNewTaskButton(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditTaskScreen(
              task: TaskEntity(),
            ),
          ));
        },
        label: Row(
          children: const [
            Text('Add New Task'),
            SizedBox(
              width: 5.0,
            ),
            Icon(
              CupertinoIcons.add_circled_solid,
            ),
          ],
        ));
  }

  Widget deleteAllTaskButton() {
    return MaterialButton(
      color: const Color(0xffEAEFF5),
      onPressed: () {
       context.read<TaskListBloc>().add(TaskListDeleteAll());
      },
      textColor: secondaryTextColor,
      elevation: 0.0,
      child: Row(
        children: const [
          Text('Delete All'),
          SizedBox(
            width: 4.0,
          ),
          Icon(
            CupertinoIcons.delete,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget emptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.task_outlined,
          size: 120,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Your task list is empty',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }

  Widget appBarHomeScreen(
      ThemeData themeData, TextEditingController controller) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          themeData.colorScheme.primary,
          themeData.colorScheme.primaryVariant,
        ],
      )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('To Do List',
                    style: themeData.textTheme.headline6!
                        .apply(color: themeData.colorScheme.onPrimary)),
                Icon(Icons.task_outlined,
                    color: themeData.colorScheme.onPrimary),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            searchBox(themeData, controller),
          ],
        ),
      ),
    );
  }

  Widget searchBox(ThemeData themeData, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 38,
        decoration: BoxDecoration(
            color: themeData.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(19),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
              ),
            ]),
        child: Center(
          child: TextField(
            onChanged: (value) {
              context.read<TaskListBloc>().add(TaskListSearch(value));
            },
            controller: controller,
            decoration: const InputDecoration(
              prefixIcon: Icon(CupertinoIcons.search),
              label: Text('Search tasks...'),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget manageTask(
      BuildContext context, TaskEntity task, ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditTaskScreen(task: task),
            ));
          });
        },
        child: itemsAndRemoval(task, themeData),
      ),
    );
  }

  Widget itemsAndRemoval(TaskEntity task, ThemeData themeData) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          task.delete();
          setState(() {});
        }
      },
      child: items(themeData, task),
    );
  }

  Widget items(ThemeData themeData, TaskEntity task) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: themeData.colorScheme.surface,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          MyCheckBox(
            value: task.isCompleted,
            onTap: () {
              setState(() {
                task.isCompleted = !task.isCompleted;
                task.save();
              });
            },
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              task.name,
              style: TextStyle(
                  fontSize: 18,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null),
            ),
          ),
          Container(
            width: 5,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8)),
              color: task.getColor(),
            ),
          ),
        ],
      ),
    );
  }
}
