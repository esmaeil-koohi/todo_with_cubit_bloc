part of 'active_todo_count_cubit.dart';

class ActiveTodoCountState extends Equatable{
  final int activeTodoCount;

  ActiveTodoCountState({ required this.activeTodoCount});

  factory ActiveTodoCountState.initial(){
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  String toString() {
    return 'ActiveTodoCountState{activeTodoCount: $activeTodoCount}';
  }

  ActiveTodoCountState copyWith({int? activeTodoCount}){
    return ActiveTodoCountState(activeTodoCount: activeTodoCount ?? this.activeTodoCount);
  }
}
