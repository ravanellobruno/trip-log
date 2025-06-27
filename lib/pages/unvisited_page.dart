import 'package:flutter/material.dart';
import '../components/places/places_page.dart';
import '../enums/place_type_enum.dart';
import '../enums/page_enum.dart';

class UnvisitedPage extends StatelessWidget {
  const UnvisitedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlacesPage(
      type: PlaceTypeEnum.unvisited,
      cards: {
        'moveTo': PlaceTypeEnum.visited,
        'moveLabel': PageEnum.visited.label,
        'btn': 'Visitei',
      },
    );
  }
}
