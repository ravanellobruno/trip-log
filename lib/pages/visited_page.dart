import 'package:flutter/material.dart';
import '../components/places/places_page.dart';
import '../enums/place_type_enum.dart';
import '../enums/page_enum.dart';

class VisitedPage extends StatelessWidget {
  const VisitedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlacesPage(
      type: PlaceTypeEnum.visited,
      cards: {
        'moveTo': PlaceTypeEnum.unvisited,
        'moveLabel': PageEnum.unvisited.label,
        'btn': 'Desfazer',
      },
    );
  }
}
