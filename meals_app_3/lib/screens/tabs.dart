import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _activeTabIndex = 0;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      Navigator.of(
        context,
      ).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var activeTitle = 'Categories';
    Widget activeScreen = CategoriesScreen();

    final meals = ref.watch(mealsProvider);
    final favoriteMealsIds = ref.watch(favoriteMealsProvider);

    if (_activeTabIndex == 1) {
      activeTitle = 'Your Favorites';
      activeScreen = MealsScreen(
        meals: meals
            .where((meal) => favoriteMealsIds.contains(meal.id))
            .toList(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activeScreen,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'Favorites',
          ),
        ],
        onTap: (value) {
          setState(() {
            _activeTabIndex = value;
          });
        },
        currentIndex: _activeTabIndex,
      ),
    );
  }
}
