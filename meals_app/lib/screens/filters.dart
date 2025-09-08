import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFreeFilterChecked = false;
  var _isLactoseFreeFilterChecked = false;
  var _isVegetarianFilterChecked = false;
  var _isVeganFilterChecked = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFreeFilterChecked = widget.currentFilters[Filter.glutenFree]!;
    _isLactoseFreeFilterChecked = widget.currentFilters[Filter.lactoseFree]!;
    _isVegetarianFilterChecked = widget.currentFilters[Filter.vegetarian]!;
    _isVeganFilterChecked = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),

      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();

      //     if (identifier == 'meals') {
      //       Navigator.of(context).pop();
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFreeFilterChecked,
            Filter.lactoseFree: _isLactoseFreeFilterChecked,
            Filter.vegetarian: _isVegetarianFilterChecked,
            Filter.vegan: _isVeganFilterChecked,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _isGlutenFreeFilterChecked,
              onChanged: (isChecked) {
                setState(() {
                  _isGlutenFreeFilterChecked = isChecked;
                });
              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include Gluten-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isLactoseFreeFilterChecked,
              onChanged: (isChecked) {
                setState(() {
                  _isLactoseFreeFilterChecked = isChecked;
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include Lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isVegetarianFilterChecked,
              onChanged: (isChecked) {
                setState(() {
                  _isVegetarianFilterChecked = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include Vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isVeganFilterChecked,
              onChanged: (isChecked) {
                setState(() {
                  _isVeganFilterChecked = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include Vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
