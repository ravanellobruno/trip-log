import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgPicker extends StatefulWidget {
  final String? base64Img;
  final Function(String?) onImgChange;

  const ImgPicker({
    super.key,
    required this.base64Img,
    required this.onImgChange,
  });

  @override
  State<ImgPicker> createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  String? _base64Img;

  @override
  void didUpdateWidget(ImgPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.base64Img != oldWidget.base64Img) {
      setState(() => _base64Img = widget.base64Img);
    }
  }

  void _changeImg(String? base64) {
    setState(() => _base64Img = base64);
    widget.onImgChange(base64);
  }

  Future<void> _pickImg(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);

    if (file != null) {
      final bytes = await File(file.path).readAsBytes();
      final base64 = base64Encode(bytes);
      _changeImg(base64);
    }
  }

  void _clearImg() {
    _changeImg(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(15, 39, 60, 79),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Imagem', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _base64Img != null
                  ? Image.memory(
                    base64Decode(_base64Img!),
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                  )
                  : Container(
                    width: 110,
                    height: 110,
                    color: const Color.fromARGB(255, 206, 231, 255),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImg(ImageSource.camera),
                    child: const Icon(Icons.camera_alt, size: 24),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImg(ImageSource.gallery),
                    child: const Icon(Icons.image, size: 24),
                  ),
                  if (_base64Img != null)
                    ElevatedButton(
                      onPressed: _clearImg,
                      child: const Icon(
                        Icons.delete,
                        size: 24,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
