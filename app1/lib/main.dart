import 'package:app1/cubit/project3/cubitManagemnt.dart/task_cubit.dart';
import 'package:app1/database.dart/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

import 'cubit/project3.page.dart';


main()    async {
  



 WidgetsFlutterBinding
        .ensureInitialized(); 
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
 
  Hive.registerAdapter(TaskModelAdapter());
    Hive.initFlutter(appDocumentDirectory.path);




  
  runApp(const Center(child: MyApp()));
}

// ignore: camel_case_types
class welcomePage extends StatelessWidget {
  welcomePage({super.key});
 final ValueNotifier<bool> _touchSkip = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Scaffold(
          body: ValueListenableBuilder<bool>(
            builder: (context, value, child) {
              return value
                  ? const Project3View()
                  : Center(
                      child: Center(
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          Lottie.asset("lib/assets/lottie/Lottie_quiz.json"),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 60),
                                  child: ElevatedButton(
                                    child: const Text("skip  "),
                                    onPressed: () {
                                      _touchSkip.value = true;
                                      print(_touchSkip);
                                      
                                
                                      
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                                          ),
                      ));
            },
            valueListenable: _touchSkip,
          ),
        );
      },
    );

  }
}



class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  final ValueNotifier<bool> _touchSkip = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Scaffold(
          body: ValueListenableBuilder<bool>(
            builder: (context, value, child) {
              return value
                  ? const Project3View()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset("lib/assets/lottie/Lottie_quiz.json"),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 60),
                                  child: ElevatedButton(
                                    child: const Text("Skip"),
                                    onPressed: () {
                                      _touchSkip.value = true;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
            },
            valueListenable: _touchSkip,
          ),
        );
      },
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShoppingCubit>(
          
          create: (_) => ShoppingCubit(),
        ),
        BlocProvider<PageCubit>(
          create: (_) => PageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       
        home: welcomePage(),
      ),
    );
  }
}





















class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PopupMenuButton Örneği')),
      body: Center(
        child: PopupMenuButton<String>(
          onSelected: (value) {
            print('Seçilen seçenek: $value');
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Seçenek 1',
              child: Text('Seçenek 1'),
            ),
            const PopupMenuItem(
              value: 'Seçenek 2',
              child: Text('Seçenek 2'),
            ),
            const PopupMenuItem(
              value: 'Seçenek 3',
              child: Text('Seçenek 3'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class Name extends StatelessWidget {
  const Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      body: const Project3View(),
    );
  }
}

*/

