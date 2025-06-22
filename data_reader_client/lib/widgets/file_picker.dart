import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerButton extends StatelessWidget {
  const FilePickerButton({super.key, required this.onSubmit});

  final void Function(String fileContent) onSubmit;

  Future<void> _pickCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null || result.files.single.path == null) {
      print('Anulowano wybór pliku');
      return;
    }
    onSubmit(await File(result.files.single.path!).readAsString());
  }

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: _pickCsvFile,
    child: const Text('Dodaj plik CSV'),
  );
}
