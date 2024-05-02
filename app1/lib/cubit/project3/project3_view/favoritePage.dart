
import 'package:app1/cubit/project3/cubitManagemnt.dart/task_cubit.dart';

import 'package:app1/database.dart/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});


  @override
  Widget build(BuildContext context) {

   

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: Center(
          child: BlocBuilder<ShoppingCubit, List<TaskModel>>(
            builder: (context, state) {
              return Center(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                        

                               

                    Text(state.length.toString()),
                    CircularPercentIndicator(
                      curve: Curves.fastOutSlowIn,
                      animateFromLastPercent: true,
                      animation: true,
                      animationDuration: 1000,
                      radius: 100.0,
                      lineWidth: 25.0,
                      percent: context.read<ShoppingCubit>().percentage(),  
                      header: const Text("Tamamlanma yüzdesi"),

                      

                      center:  Text( '%${(context.read<ShoppingCubit>().percentage() * 100).toInt()}'),

                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
