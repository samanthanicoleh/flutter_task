import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../constants/colors.dart';
import 'favourited_movies_tab.dart';
import 'popular_movies_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => PersistentTabView(
        context,
        key: UniqueKey(),
        screens: _buildTabs(),
        items: _navBarsItems(),
        backgroundColor: AppColors.black,
        navBarStyle: NavBarStyle.style3,
      );

  List<Widget> _buildTabs() => const [
        PopularMoviesTab(),
        FavouritedMoviesTab(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.movie),
          title: 'Movies',
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.textColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.bookmark_add),
          title: 'Favourites',
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.textColor,
        ),
      ];
}
