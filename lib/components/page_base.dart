import 'package:flutter/material.dart';
import 'bottom_menu.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../enums/page_enum.dart';

class PageBase extends StatelessWidget {
  const PageBase({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final selectedPage = PageEnum.values[appState.pageIndex];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 12),
          child: IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 26),
            onPressed: () {
              appState.setPageIndex(PageEnum.unvisited.index);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.lightBlueAccent,
              ),
            ),
          ),
        ),
        title: Column(
          children: [
            const Text(
              'TripLog',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey,
              ),
            ),
            Text(selectedPage.intro, style: const TextStyle(fontSize: 17)),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: KeyedSubtree(
          key: ValueKey(selectedPage.index),
          child: selectedPage.page,
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
