import 'package:flutter/material.dart';
import '../components/places/places_page.dart';
import '../enums/place_type_enum.dart';
import '../models/place_model.dart';
import '../shared_utils/toast_utils.dart';
import '../enums/toast_type_enum.dart';
import '../enums/page_enum.dart';
import '../../repositories/places_repo.dart';

class UnvisitedPage extends StatefulWidget {
  const UnvisitedPage({super.key});

  @override
  State<UnvisitedPage> createState() => _UnvisitedPageState();
}

class _UnvisitedPageState extends State<UnvisitedPage> {
  List<Place> places = [];

  void _getPlaces() async {
    try {
      final data = await PlacesRepo.getAll(PlaceTypeEnum.unvisited);
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
    return PlacesPage(
      places: places,
      cardsParams: {
        'btnChild': const Text('Visitei', style: TextStyle(fontSize: 15)),
        'onBtnPressed': (place) {
          try {
            PlacesRepo.move(PlaceTypeEnum.visited, place);
            _getPlaces();

            ToastUtils.showToast(
              'Registro movido para: ${PageEnum.visited.label}',
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
  }
}
