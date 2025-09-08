import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  var _activeTabIndex = 0;
  final Set<String> _favoriteMealsIds = {};
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(String mealId) {
    if (_favoriteMealsIds.contains(mealId)) {
      setState(() {
        _favoriteMealsIds.remove(mealId);
      });
      _showInfoMessage('Removed from favorites');
    } else {
      setState(() {
        _favoriteMealsIds.add(mealId);
      });
      _showInfoMessage('Added to favorites');
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      var result =
          await Navigator.of(
            context,
          ).push<Map<Filter, bool>>(
            MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                currentFilters: _selectedFilters,
              ),
            ),
          );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var activeTitle = 'Categories';
    Widget activeScreen = CategoriesScreen(
      onToggleMealFavoriteStatus: _toggleMealFavoriteStatus,
      filters: _selectedFilters,
    );

    if (_activeTabIndex == 1) {
      activeTitle = 'Your Favorites';
      activeScreen = MealsScreen(
        meals: dummyMeals
            .where((meal) => _favoriteMealsIds.contains(meal.id))
            .toList(),
        onToggleMealFavoriteStatus: _toggleMealFavoriteStatus,
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
