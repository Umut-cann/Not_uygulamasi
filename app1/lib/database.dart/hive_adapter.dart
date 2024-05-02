import 'package:hive/hive.dart';

import 'package:app1/database.dart/hive_model.dart';

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  int get typeId => 1;

  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      reader.readString(),
      reader.readString(),
      reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.category);
    writer.writeString(obj.name);
    writer.writeBool(obj.isChecked);
  }
}



