part of 'todo_filter_cubit.dart';

class TodoFilterState extends Equatable {
  final Filter filter;

  TodoFilterState({required this.filter});

  factory TodoFilterState.initail(){
    return TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  String toString() {
    return 'TodoFilterState{filter: $filter}';
  }

  TodoFilterState copyWith({Filter? filter}){
    return TodoFilterState(filter: filter ?? this.filter);
  }

}

