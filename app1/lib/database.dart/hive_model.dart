import 'package:hive/hive.dart';

 part 'hive_model.g.dart';
@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String category;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool isChecked;

  TaskModel(this.category, this.name, this.isChecked);
}
