import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    return NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(
          Theme.of(context).textTheme.bodySmall!.copyWith(
                letterSpacing: 0.5,
                fontSize: 10,
                color: colorscheme.onSecondary,
              ),
        ),
        ),
        child: NavigationBar(
          backgroundColor: colorscheme.secondary,
          surfaceTintColor: Colors.transparent,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_max_outlined,color: colorscheme.onSecondary,), 
            label: 'Home',
            selectedIcon: Icon(Icons.home,color: colorscheme.onSecondary,),
            ),
            NavigationDestination(icon: Icon(Icons.youtube_searched_for_outlined,color: colorscheme.onSecondary,), 
            label: 'Shorts',
            selectedIcon: Icon(Icons.youtube_searched_for_outlined,color: colorscheme.onSecondary,),
            ),
             Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: colorscheme.onSecondary,
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: colorscheme.onSecondary,
            ),
          ),
             NavigationDestination(
            icon: Icon(
              Icons.subscriptions_outlined,
              color: colorscheme.onSecondary,
            ),
            label: 'Subscriptions',
            selectedIcon: Icon(
              Icons.subscriptions,
              color: colorscheme.onSecondary,
            ),
          ),
          const NavigationDestination(
            icon: CircleAvatar(
              radius: 16,
              child: Text('M'),
            ),
            label: 'You',
          ),
          ],
        ));
  }
}
