import 'package:flutter/material.dart';
import '../../models/place_model.dart';
import 'card_img.dart';
import 'actions_modal.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final Map<String, Object> cardsParams;

  const PlaceCard({super.key, required this.place, required this.cardsParams});

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ActionsModal(place: place, cardsParams: cardsParams);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        children: [
          if (place.base64Img != null) CardImg(img: place.base64Img!),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color.fromARGB(161, 0, 44, 74),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    place.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.more_horiz, size: 32),
                        color: Colors.cyanAccent,
                        onPressed: () => _showModal(context),
                      ),
                      ElevatedButton(
                        onPressed:
                            () => (cardsParams['onBtnPressed'] as Function)(
                              place,
                            ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: cardsParams['btnChild'] as Widget,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
