import 'package:app1/database.dart/hive_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
//import 'package:state_managament/cubit/project3/project3_view/home.dart';

// Veritabanındaki verileri al

// task item -> task modeş
abstract class ShoppingCubitState {}

/*class ShoppingList extends ShoppingCubitState {
  final List<TaskModel> items;
  ShoppingList(this.items);
}
*/

class FavoritesList extends ShoppingCubitState {
  final List<TaskModel> favoriteItems;
  FavoritesList(this.favoriteItems);
}

class ShoppingCubit extends Cubit<List<TaskModel>> {
  final kzero = 0;
 late Box<TaskModel> todoBox; //=await Hive.openBox("a");
  //Box<TaskModel> todoBox = await Hive.openBox<TaskModel>('todoBox');

  ShoppingCubit() : super([]) {
    //getTodosFromDatabase();
    initialize();
  }

  Future<void> initialize() async {
    
    //WidgetsFlutterBinding
      //  .ensureInitialized(); // Flutter bağlamınızın başlatıldığından emin olun
    //final appDocumentDirectory = await getApplicationDocumentsDirectory();
    //Hive.init(appDocumentDirectory.path);
    //Hive.registerAdapter(TaskModelAdapter());
    //Hive.initFlutter(appDocumentDirectory.path);

     todoBox = await Hive.openBox<TaskModel>('todoBox');
    print(todoBox.length);
    emit(todoBox.values.toList());
  }

  void getTodosFromDatabase() async {
    final todoBox = await Hive.openBox<TaskModel>('todoBox');
    final todos = todoBox.values.toList();
    emit(todos);
  }

  // Veritabanına veri ekleme

  void addTodoToDatabase(TaskModel todo) async {
    final todoBox = await Hive.openBox<TaskModel>('todoBox');

    todoBox.add(todo);
    final todos = todoBox.values.toList();

    emit(todos);
    //getTodosFromDatabase(); // Verileri güncelle
  }




  void secenekler(String value, TaskModel model) async {
    final todoBox = await Hive.openBox<TaskModel>('todoBox');



    int index = todoBox.values.toList().indexWhere((task) =>
        task.name == model.name &&
        task.category == model.category &&
        task.isChecked == model.isChecked);

    print(index);
    todoBox.deleteAt(index);

    emit(todoBox.values.toList());

  
  }

  Future update(var oldmodel, TaskModel taskModel) async {
    final todoBox = await Hive.openBox<TaskModel>('todoBox');

    int index = todoBox.values.toList().indexWhere((task) => task == oldmodel);

    print(index);
   
    await todoBox.putAt(index, taskModel);
    List<TaskModel> gonder = todoBox.values.toList();
    emit(gonder);
  }

  Future<void> DatabaseFiltreleme(String kategori) async {
    final todoBox = await Hive.openBox<TaskModel>('todoBox');

    if (kategori == 'seciniz') {
      emit(todoBox.values.toList());
      print("kategori yanlış");
    } else {
      print(kategori);
      List<TaskModel> filtrelenmisVeriler = [];

      todoBox.values.forEach((element) {
        TaskModel task = element as TaskModel; 
        if (task.category == kategori) {
          filtrelenmisVeriler.add(task);
        }
      });

      emit(filtrelenmisVeriler);
    }
  }

  delete(int index) async {
    final todoBox = await Hive.openBox<TaskModel>('todoBox');

   
    todoBox.deleteAt(index);

    
  }


  void checkbox(TaskModel model) async {
    final todoBox = await Hive.openBox<TaskModel>('todoBox');

    for (var i = kzero; i < todoBox.length; i++) {
      if (todoBox.getAt(i) == model) {
        model.isChecked = !model.isChecked;
        todoBox.putAt(i, model);
      }
    }

    List<TaskModel> filteredList = todoBox.values.toList();


    if (state.length < todoBox.length) {
      filteredList =
          state.where((item) => item.category == model.category).toList();
      emit(filteredList);
    }
    emit(filteredList);
  }

  double percentage() {
    final liste = List<TaskModel>.from(state);
    int sayac = 0;

    if (liste.length == kzero) {
      return kzero.toDouble();
    }

    for (int i = kzero; i < liste.length; i++) {
      if (liste[i].isChecked) {
        sayac++;
      }
    }
    return sayac / liste.length;

    
  }

 
}
