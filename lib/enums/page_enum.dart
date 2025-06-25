import 'package:flutter/material.dart';
import '../pages/visited_page.dart';
import '../pages/unvisited_page.dart';
import '../pages/add_or_update.dart';

enum PageEnum { unvisited, visited, addOrUpdate }

extension PageEnumExtension on PageEnum {
  String get label {
    switch (this) {
      case PageEnum.unvisited:
        return 'Não visitei';
      case PageEnum.visited:
        return 'Já visitei';
      case PageEnum.addOrUpdate:
        return 'Cadastro';
    }
  }

  String get intro {
    switch (this) {
      case PageEnum.unvisited:
        return 'Lugares que não visitei';
      case PageEnum.visited:
        return 'Lugares que já visitei';
      case PageEnum.addOrUpdate:
        return 'Cadastro';
    }
  }

  Widget get page {
    switch (this) {
      case PageEnum.unvisited:
        return const UnvisitedPage();
      case PageEnum.visited:
        return const VisitedPage();
      case PageEnum.addOrUpdate:
        return const AddOrUpdate();
    }
  }

  IconData get icon {
    switch (this) {
      case PageEnum.unvisited:
        return Icons.list;
      case PageEnum.visited:
        return Icons.checklist;
      case PageEnum.addOrUpdate:
        return Icons.add;
    }
  }
}
