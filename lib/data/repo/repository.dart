import 'package:flutter/material.dart';
import 'package:todo_bloc/data/source/source.dart';

class Repository<T> with ChangeNotifier implements DataSource{
  final DataSource<T> localDataSource;

  Repository(this.localDataSource);

  @override
  Future createOrUpdate(data) async {
   final T  result = await localDataSource.createOrUpdate(data);
   notifyListeners();
   return result;
  }

  @override
  Future<void> delete(data) async {
   localDataSource.delete(data);
  notifyListeners();
  }

  @override
  Future<void> deleteAll() async {
   await localDataSource.deleteAll();
   notifyListeners();
  }

  @override
  Future<void> deleteById(data) async {
  return localDataSource.deleteById(data);
  notifyListeners();
  }

  @override
  Future findById(id) {
   return localDataSource.findById(id);
  }

  @override
  Future<List<T>> getAll({String searchKeyword = ''}) {
    return localDataSource.getAll(searchKeyword: searchKeyword);
  }


}