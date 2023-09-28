import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
// import 'package:meals_app/screen/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

//standardising the keys
// enum Filter { glutenFree, lactoseFree, vegetarian, vegan }==> shifting to FiltersNotifier
// class FiltersScreen extends StatefulWidget {
// class FiltersScreen extends ConsumerStatefulWidget {
class FiltersScreen extends ConsumerWidget {
  // connecting filters.dart to provider
  const FiltersScreen({super.key
      //  required this.currentFilter
      });
  // final Map<Filter, bool> currentFilter;--> getting this info from provider itself

  @override
  // State<FiltersScreen> createState() {
//   ConsumerState<FiltersScreen> createState() {
//     return _FilterScreenState();
//   }
// }

// class _FilterScreenState extends State<FiltersScreen> {
// class _FilterScreenState extends ConsumerState<FiltersScreen> {
//   var _glutenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegetarianFilterSet = false;
//   var _veganFilterSet = false;

// need to save and pass currently active filters from tabs screen to filters screen and not reset them as i go back to filters screen again
  // @override
  // void initState() {
  //   super.initState();
  //   final activeFilters = ref.read(filtersProvider);
  //   // _glutenFreeFilterSet = widget.currentFilter[Filter.glutenFree]!;
  //   // _lactoseFreeFilterSet = widget.currentFilter[Filter.lactoseFree]!;
  //   // _vegetarianFilterSet = widget.currentFilter[Filter.vegetarian]!;
  //   // _veganFilterSet = widget.currentFilter[Filter.vegan]!;
  //   _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  //   _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
  //   _veganFilterSet = activeFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFiltersMeal = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body:
          //  WillPopScope(
          // WillPopScope Widget is used for returning Data when Leaving a Screen
          // onWillPop: () async /*convinient way of returning a future*/ {
          //   ref.read(filtersProvider.notifier).setFilters({
          //     Filter.glutenFree: _glutenFreeFilterSet,
          //     Filter.lactoseFree: _lactoseFreeFilterSet,
          //     Filter.vegetarian: _vegetarianFilterSet,
          //     Filter.vegan: _veganFilterSet,
          //   });
          // Navigator.of(context).pop({
          // returning a map...setting up different keys for differnet filters
          // Filter.glutenFree: _glutenFreeFilterSet,
          // Filter.lactoseFree: _lactoseFreeFilterSet,
          // Filter.vegetarian: _vegetarianFilterSet,
          // Filter.vegan: _veganFilterSet,
          // } // This maped data we need to acessed into tabs screen from where actually we navigated to this screen
          // );
          // return false; // confirming wheather to navigate back or not....we are returning false here as we are manually navigating back above(not poping twice)..if we do not have any logic to navigate back then return true;
          // return true;
          // },
          // child:
          Column(children: [
        SwitchListTile(
          // value: _glutenFreeFilterSet,
          value: activeFiltersMeal[Filter.glutenFree]!,
          onChanged: (isChecked) {
            // setState(() {
            //   _glutenFreeFilterSet = isChecked;
            // });
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, isChecked);
          },
          title: Text(
            "Gluten-free",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            "Only include gluten-free meals",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          // value: _lactoseFreeFilterSet,
          value: activeFiltersMeal[Filter.lactoseFree]!,
          onChanged: (isChecked) {
            // setState(() {
            //   _lactoseFreeFilterSet = isChecked;
            // });
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, isChecked);
          },
          title: Text(
            "Lactose-free",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            "Only include lactose-free meals",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFiltersMeal[Filter.vegetarian]!,
          onChanged: (isChecked) {
            // setState(() {
            //   _vegetarianFilterSet = isChecked;
            // });
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, isChecked);
          },
          title: Text(
            "Vegetarian Meals",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            "Only include veg meals",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          // value: _veganFilterSet,
          value: activeFiltersMeal[Filter.vegan]!,
          onChanged: (isChecked) {
            // setState(() {
            //   _veganFilterSet = isChecked;
            // });
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegan, isChecked);
          },
          title: Text(
            "Vegan Meals",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            "Only include vegan meals",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
      ]),
      // ),
    );
  }
}
