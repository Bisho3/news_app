import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/component.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  NavigatorTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: () {
                  cubit.changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.business,
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports,
                ),
                label: 'Sports',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.science,
                ),
                label: 'Science',
              ),
            ],
          ),
        );
      },
    );
  }
}
