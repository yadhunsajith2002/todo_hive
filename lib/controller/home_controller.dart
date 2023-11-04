import 'package:flutter_todo/model/person_model.dart';
import 'package:hive/hive.dart';

class HomeController {
  final Box<Person> personBox = Hive.box('personBox');

  Future<List<Person>> getData() async {
    return personBox.values.toList();
  }

  Future addData({required Person data}) async {
    await personBox.add(data);
  }

  Future updateData({required Person updatedData, required int index}) async {
    await personBox.putAt(index, updatedData);
  }

  Future deleteData({required int index}) async {
    await personBox.deleteAt(index);
  }
}
