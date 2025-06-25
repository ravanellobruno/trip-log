import 'package:flutter/material.dart';
import '../../models/place_model.dart';
import 'place_card.dart';

class PlacesPage extends StatelessWidget {
  final List<Place> places;
  final Map<String, Object> cardsParams;

  const PlacesPage({
    super.key,
    required this.places,
    required this.cardsParams,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: places.length,
            itemBuilder: (context, i) {
              return PlaceCard(place: places[i], cardsParams: cardsParams);
            },
          ),
        ),
      ],
    );
  }
}
