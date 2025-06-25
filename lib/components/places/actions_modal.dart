import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/place_model.dart';
import '../../providers/places_state.dart';
import '../../enums/page_enum.dart';
import '../../repositories/places_repo.dart';
import '../../shared_utils/toast_utils.dart';
import '../../enums/toast_type_enum.dart';
import '../../providers/app_state.dart';

class ActionsModal extends StatelessWidget {
  final Place place;
  final Map<String, Object> cardsParams;

  const ActionsModal({
    super.key,
    required this.place,
    required this.cardsParams,
  });

  void _edit(BuildContext context) {
    final appState = context.read<AppState>();
    final placesState = context.read<PlacesState>();

    appState.setPageIndex(PageEnum.addOrUpdate.index);
    placesState.setIdToUpdate(place.id);
    Navigator.pop(context);
  }

  void _delete(BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      await PlacesRepo.delete(place.id!);

      ToastUtils.showToast(
        'Registro excluído com sucesso',
        ToastTypeEnum.success,
      );

      navigator.pop();

      final onDeleted = cardsParams['onDeleted'] as void Function();
      onDeleted();
    } catch (e) {
      ToastUtils.showToast(
        'Ocorreu um erro ao deletar o registro',
        ToastTypeEnum.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Editar'),
            onTap: () => _edit(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Excluir'),
            onTap: () => _delete(context),
          ),
        ],
      ),
    );
  }
}
