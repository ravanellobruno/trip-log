import 'package:flutter/material.dart';
import '../components/places/places_page.dart';
import '../enums/place_type_enum.dart';
import '../models/place_model.dart';
import '../shared_utils/toast_utils.dart';
import '../enums/toast_type_enum.dart';
import '../enums/page_enum.dart';
import '../../repositories/places_repo.dart';

class VisitedPage extends StatefulWidget {
  const VisitedPage({super.key});

  @override
  State<VisitedPage> createState() => _VisitedPageState();
}

class _VisitedPageState extends State<VisitedPage> {
  List<Place> places = [];

  void _getPlaces() async {
    try {
      final data = await PlacesRepo.getAll(PlaceTypeEnum.visited);
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
        'btnChild': const Text('Desfazer', style: TextStyle(fontSize: 14)),
        'onBtnPressed': (place) {
          try {
            PlacesRepo.move(PlaceTypeEnum.unvisited, place);
            _getPlaces();

            ToastUtils.showToast(
              'Registro movido para: ${PageEnum.unvisited.label}',
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
