import 'package:app1/cubit/project3/project3_view/favoritePage.dart';
import 'package:app1/cubit/project3/project3_view/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Project3 extends StatelessWidget {
  const Project3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PageCubit>().state;
    Widget widgetToShow;
    if (state == ScreenState.Screen1) {
      widgetToShow = const HomeView();
    } else if (state == ScreenState.Screen2) {
      widgetToShow = const FavoritesPage();
    } else {
      widgetToShow = Container();
    }
    return Scaffold(
      body: widgetToShow,
    );
  }
}

class Project3View extends StatelessWidget {
  const Project3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Project3(),
      bottomNavigationBar: BlocBuilder<PageCubit, ScreenState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            backgroundColor: Colors.white,

            items: const [
               Icon(Icons.home),
              // label: 'Ana Sayfa',

               Icon(Icons.settings),
            
            ],
            color: Colors.blue,
            onTap: (index) {
              final screenCubit = context.read<PageCubit>();
              switch (index) {
                case 0:
                  screenCubit.showScreen1();
                  break;
                case 1:
                  screenCubit.showScreen2();
                  break;
              }
            },
            letIndexChange: (index) => true,
          );
        },
      ),
    );
  }
}


enum ScreenState {  Screen1, Screen2 }

class PageCubit extends Cubit<ScreenState> {
  PageCubit() : super(ScreenState.Screen1);

  void showScreen1() => emit(ScreenState.Screen1);
  void showScreen2() => emit(ScreenState.Screen2);
}
