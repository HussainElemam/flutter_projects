import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsetsGeometry.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            onTap: () {
              onSelectScreen('meals');
            },
            leading: Icon(
              Icons.restaurant_menu,
              size: 26,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              onSelectScreen('filters');
            },
            leading: Icon(
              Icons.settings,
              size: 26,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
