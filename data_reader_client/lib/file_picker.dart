import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as fp;

class FilePicker extends StatelessWidget {
  const FilePicker({super.key});

  Future<void> _pickCsvFile() async {
    final result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null || result.files.single.path == null) {
      print('Anulowano wybór pliku');
      return;
    }
    final filePath = result.files.single.path!;
    print("wybarno $filePath");
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: _pickCsvFile,
      child: const Text('Dodaj plik CSV'),
    );
  }
}
