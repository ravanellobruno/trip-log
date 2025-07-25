import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place_model.dart';
import '../providers/places_state.dart';
import '../providers/app_state.dart';
import '../shared_utils/toast_utils.dart';
import '../enums/toast_type_enum.dart';
import '../components/form/input_text.dart';
import '../components/form/img_picker.dart';
import '../../repositories/places_repo.dart';
import '../enums/place_type_enum.dart';

class AddOrUpdate extends StatefulWidget {
  const AddOrUpdate({super.key});

  @override
  State<AddOrUpdate> createState() => _AddOrUpdateState();
}

class _AddOrUpdateState extends State<AddOrUpdate> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  Place? _placeToUpdate;
  String? _base64Img;
  var _btnTxt = 'Adicionar';

  void _clearIdToUpdate(PlacesState placesState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      placesState.setIdToUpdate(null);
    });
  }

  void _checkIfIsUpdate() async {
    final placesState = context.read<PlacesState>();

    if (placesState.idToUpdate != null) {
      try {
        _placeToUpdate = await PlacesRepo.getById(placesState.idToUpdate!);
        _clearIdToUpdate(placesState);

        if (_placeToUpdate == null) {
          ToastUtils.showToast(
            'O registro não foi encontrado no banco de dados',
            ToastTypeEnum.error,
          );

          return;
        }

        _btnTxt = 'Atualizar';
        _name.text = _placeToUpdate!.name;
        _description.text = _placeToUpdate!.description!;
        setState(() => _base64Img = _placeToUpdate!.base64Img);
      } catch (e) {
        ToastUtils.showToast(
          'Ocorreu um erro ao buscar o registro para editar',
          ToastTypeEnum.error,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfIsUpdate();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _addOrUpdate(bool isUpdate) async {
    try {
      isUpdate
          ? await PlacesRepo.update(
            Place(
              base64Img: _base64Img,
              name: _name.text,
              description: _description.text,
              id: _placeToUpdate!.id,
              type: _placeToUpdate!.type,
            ),
          )
          : await PlacesRepo.add(
            Place(
              base64Img: _base64Img,
              name: _name.text,
              description: _description.text,
              type: PlaceTypeEnum.unvisited,
            ),
          );
    } catch (e) {
      ToastUtils.showToast('Ocorreu um erro na operação', ToastTypeEnum.error);
    }

    ToastUtils.showToast(
      'Registro ${isUpdate ? 'atualizado' : 'adicionado'} com sucesso',
      ToastTypeEnum.success,
    );
  }

  void _resetForm() {
    final focusScope = FocusScope.of(context);

    _name.clear();
    _description.clear();
    focusScope.unfocus();
    setState(() => _base64Img = null);
  }

  void _goToPreviusPage() {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.setPageIndex(appState.prevPageIndex);
  }

  void _submit() async {
    if (_name.text.isEmpty) {
      ToastUtils.showToast(
        'É necessário informar o nome do lugar',
        ToastTypeEnum.error,
      );

      return;
    }

    var isUpdate = _placeToUpdate != null;
    await _addOrUpdate(isUpdate);

    if (isUpdate) {
      _goToPreviusPage();
    }

    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InputText(controller: _name, label: 'Nome'),
              const SizedBox(height: 16),
              InputText(
                controller: _description,
                label: 'Descrição',
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              ImgPicker(
                base64Img: _base64Img,
                onImgChange: (base64) {
                  setState(() => _base64Img = base64);
                },
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  '$_btnTxt lugar',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
