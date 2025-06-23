import 'package:data_reader_client/logic/app_controller.dart';
import 'package:data_reader_client/style/text_theme.dart';
import 'package:data_reader_client/widgets/file_picker.dart';
import 'package:data_reader_client/widgets/fixed_textfield.dart';
import 'package:flutter/material.dart';

class DatasetInputSection extends StatefulWidget {
  const DatasetInputSection({super.key});

  @override
  State<DatasetInputSection> createState() => _DatasetInputSectionState();
}

class _DatasetInputSectionState extends State<DatasetInputSection> {
  String _name = "";
  String? _fileContent;
  String? _fileName;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        children: [
          FilePickerButton(
            onSubmit: (content, name) => setState(() {
              _fileContent = content;
              _fileName = name;
            })
          ),
          const SizedBox(height: 20),
          _fileContent == null ? const SizedBox() : FilledButton(
              onPressed: () => AppController.of(context)
                  .addDataset(_name, _fileContent!, context),
              child: const Text('Dodaj Dataset')
          ),
        ],
      ),
      Column(
        children: [
          FixedTextField(
              hintText: 'dataset name',
              onChanged: (val) => _name = val
          ),
          const SizedBox(height: 20),
          _fileContent == null ? const SizedBox() : Text(
            'Wybrany plik: $_fileName',
            style: context.texts.titleMedium,
          ),
        ],
      )
    ],
  );
}
