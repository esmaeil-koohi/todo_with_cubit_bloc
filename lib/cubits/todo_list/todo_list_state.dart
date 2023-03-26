part of 'todo_list_cubit.dart';

class TodoListState extends Equatable{
  List<Todo> todos;

  TodoListState({required this.todos});

  factory TodoListState.initial(){
    return TodoListState(todos: [
      Todo(id: '1' , desc: 'Clean the room'),
      Todo(id: '2' , desc: 'Wash the dish'),
      Todo(id: '3' , desc: 'Do homework'),

    ]);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  String toString() {
    return 'TodoListState{todos: $todos}';
  }

  TodoListState copyWith({List<Todo>? todos}){
    return TodoListState(todos: todos ?? this.todos);
  }
}