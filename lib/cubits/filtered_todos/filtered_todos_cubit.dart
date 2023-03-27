import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_bloc/cubits/todo_search/todo_search_cubit.dart';
import '../../models/todo_model.dart';
import '../todo_filter/todo_filter_cubit.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  late StreamSubscription todoFilteredSubscription;
  late StreamSubscription todoSearchSubscription;
  late StreamSubscription todoListSubscription;

  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  FilteredTodosCubit({
   required this.todoFilterCubit,
   required this.todoSearchCubit,
   required this.todoListCubit}) : super(FilteredTodosState.initial()){
    todoFilteredSubscription = todoFilterCubit.stream.listen((TodoFilterState todoFilterState) { });
    todoSearchSubscription = todoSearchCubit.stream.listen((TodoSearchState todoSearchState) { });
    todoListSubscription = todoListCubit.stream.listen((TodoListState todoListState) { });
  }
}
