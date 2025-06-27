import 'package:flutter/material.dart';
import '../../models/place_model.dart';
import 'place_card.dart';
import '../../enums/place_type_enum.dart';
import '../../shared_utils/toast_utils.dart';
import '../../enums/toast_type_enum.dart';
import '../../repositories/places_repo.dart';

class PlacesPage extends StatefulWidget {
  final PlaceTypeEnum type;
  final Map<String, dynamic> cards;

  const PlacesPage({super.key, required this.type, required this.cards});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  List<Place> places = [];

  Future<void> _getPlaces() async {
    try {
      final data = await PlacesRepo.getAll(widget.type);
      setState(() => places = data);
    } catch (e) {
      ToastUtils.showToast(
        'Ocorreu um erro ao buscar os registros',
        ToastTypeEnum.error,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getPlaces();
  }

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
              return PlaceCard(
                place: places[i],
                cardsParams: {
                  'btnChild': Text(
                    widget.cards['btn'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  'onBtnPressed': (place) async {
                    try {
                      await PlacesRepo.move(widget.cards['moveTo'], place);
                      await _getPlaces();

                      ToastUtils.showToast(
                        'Registro movido para: ${widget.cards['moveLabel']}',
                        ToastTypeEnum.success,
                      );
                    } catch (e) {
                      ToastUtils.showToast(
                        'Ocorreu um erro ao mover o registro',
                        ToastTypeEnum.error,
                      );
                    }
                  },
                  'onDeleted': _getPlaces,
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
