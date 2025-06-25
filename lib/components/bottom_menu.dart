import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../enums/page_enum.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return BottomNavigationBar(
      items:
          PageEnum.values.map((page) {
            return BottomNavigationBarItem(
              icon: Icon(page.icon),
              label: page.label,
            );
          }).toList(),
      currentIndex: appState.pageIndex,
      onTap: (i) => appState.setPageIndex(i),
      iconSize: 24,
      selectedIconTheme: const IconThemeData(size: 32),
      selectedItemColor: Colors.blue,
      selectedLabelStyle: const TextStyle(fontSize: 15),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
    );
  }
}
