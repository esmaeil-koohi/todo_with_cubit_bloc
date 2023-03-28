import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloc/data/data.dart';
import 'package:todo_bloc/data/repo/repository.dart';
import 'package:todo_bloc/data/source/hive_task_source.dart';
import 'package:todo_bloc/screens/home/home.dart';
import 'package:todo_bloc/theme.dart';


const taskBoxName = 'tasks';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primaryVariant));
  runApp(
      ChangeNotifierProvider<Repository<TaskEntity>>(
          create: (context) => Repository<TaskEntity>(HiveTaskDataSource(Hive.box(taskBoxName))),
          child: const MyApp()));
}

const Color primaryColor = Color(0xff794CFF);
const Color primaryVariant = Color(0xff5C0AFF);
const secondaryTextColor = Color(0xffAFBED0);
const Color normalPriorityColor = Color(0xffF09819);
const Color lowPriorityColor = Color(0xff3BE1F1);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryTextColor = const Color(0xff1D2830);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProject(primaryTextColor),
        home: const HomeScreen());
  }
}




