import 'package:app1/cubit/project3/project3_view/widgets/options_DropDown.dart';
import 'package:app1/database.dart/hive_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubitManagemnt.dart/const.dart';

import '../cubitManagemnt.dart/task_cubit.dart';

@immutable
class filtreleme extends StatelessWidget {
  const filtreleme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        onSelected: (value) {
       
          context.read<ShoppingCubit>().DatabaseFiltreleme(value);
          print('Seçilen seçenek: $value');
         
        },
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'seciniz',
                child: Text('seciniz'),
              ),
              const PopupMenuItem(
                value: 'spor',
                child: Text(
                  'spor',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const PopupMenuItem(
                value: 'sanat',
                child: Text('sanat'),
              ),
              const PopupMenuItem(
                value: 'okul',
                child: Text('okul'),
              ),
            ]);
  }
}


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double opacity = 0.0;



  @override
  Widget build(BuildContext context) {
    Color newColor = Colors.green;
    return Scaffold(
      appBar: AppBar(

backgroundColor: Colors.blue,
title:const  Text("Notlarim"),
        centerTitle: true,
        actions: const [
          
        
          filtreleme()],
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ShoppingCubit, List<TaskModel>>(
        builder: (context, state) {
          return AnimatedOpacity(
            opacity: opacity + 1,
            duration: const Duration(seconds: 1),
            child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                final item = state[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: item.isChecked? newColor:Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text(item.name),
                      enabled: !item.isChecked,
                      leading: Checkbox(
                        value: item.isChecked,
                        onChanged: (value) {
                          context.read<ShoppingCubit>().checkbox(item);
                          
                        },
                      ),
                      subtitle: Center(
                        child: Text(
                          ".${item.category}",
                          style: const TextStyle(color: Colors.black)
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz),
                        onSelected: (value) {
                          context.read<ShoppingCubit>().secenekler(
                                value,
                                TaskModel(
                                    item.category, item.name, item.isChecked),
                              );
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'sil',
                            child: Text('sil'),
                          ),
                        ],
                      ),
                      onTap: () => _showAddItemDialog(context, true, index),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context, false, -1),
        child: const Icon(Icons.add),
      ),
    );
  }
}



class AddItemDialog extends StatefulWidget {
  final bool duzenle;
  final int index;

  const AddItemDialog({this.duzenle = false, this.index = -1});

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  TextEditingController _controller = TextEditingController();
  String errorText = '';
  String selectedOption = categoryModelItem.samples.first.title
      .toString(); 

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); 
    _updateController();
  }

  @override
  void didUpdateWidget(AddItemDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duzenle != oldWidget.duzenle) {
      _updateController();
    }
  }

  void _updateController() {
    if (widget.duzenle) {
      final currentItem = context.read<ShoppingCubit>().state[widget.index];

      print(currentItem.name);
     
      selectedOption = currentItem.category;
      _controller.text = currentItem.name;
    } else {
      _controller.text = ' ';
    }
  }

  final List<String> options = ['Seçiniz', 'spor', 'okul', 'sanat'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.duzenle ? 'Not Düzenle' : 'Not Ekle'),
      content: TextField(
        controller: _controller,
        onChanged: (value) {
          setState(() {
            if (widget.duzenle) {}

            errorText = value.trim().isEmpty ? 'Bu alan boş bırakılamaz' : '';
          });
        },
        decoration: InputDecoration(
          hintText: 'not adı',
          errorText: errorText,
        ),
      ),
      actions: [
        options_categories(),
      
        ElevatedButton(
          onPressed: _controller.text.trim().isEmpty
              ? null
              : () async {
                  final item = _controller.text.trim();
                  if (widget.duzenle) {
                  
                    var current =
                        context.read<ShoppingCubit>().state[widget.index];

                    context.read<ShoppingCubit>().update(
                        current, TaskModel(selectedOption, item, false));

                  } else {
                  
                    final todo = TaskModel(selectedOption, item,
                        false); 
                    context.read<ShoppingCubit>().addTodoToDatabase(todo);
                  
                  }

                  Navigator.pop(context,
                      true); 
                },
          child: Text(widget.duzenle ? 'Düzenle' : 'Ekle'),
        ),
      ],
    );
  }

  DropdownButton options_categories() {
    return DropdownButton<String>(
      value: selectedOption,
      onChanged: (newValue) {
        setState(() {
          selectedOption = newValue!;
        });
      },
      items: options.map<DropdownMenuItem<String>>((
        String value,
      ) {
        return DropdownMenuItem<String>(
            value: value,
            child: Chip(
              label: Text(value),
             
            ));
      }).toList(),
    );
  }

 
}

void _showAddItemDialog(BuildContext context, bool duzenle, int index) {
  showDialog(
      context: context,
      builder: (context) {
        return AddItemDialog(duzenle: duzenle, index: index);
      });
}

// ignore: camel_case_types
class favoritesIcon extends StatelessWidget {
  const favoritesIcon({super.key});

  @override
  Widget build(BuildContext context) {
  
    return BlocBuilder<ConstCubit, Color>(
      builder: (context, state) {
        return (IconButton(
          icon: const Icon(
            Icons.favorite,
            color: Colors.grey,
          ),
          onPressed: () {
            context.read<ConstCubit>().toggleFavoriteColor();
          },
        ));
      },
    );
  }
}

// ignore: camel_case_types










