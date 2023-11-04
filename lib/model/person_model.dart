import 'package:hive/hive.dart';

part 'person_model.g.dart';

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? age;

  Person({required this.name, required this.age});
}
