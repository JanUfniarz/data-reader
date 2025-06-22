import 'package:data_reader_client/logic/app_controller.dart';
import 'package:data_reader_client/widgets/file_picker.dart';
import 'package:data_reader_client/widgets/fixed_textfield.dart';
import 'package:flutter/material.dart';

class ReaderClient extends StatelessWidget {
  const ReaderClient({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DatasetInputSection(),
          const Divider()
        ].map((el) => Padding(
          padding: const EdgeInsets.only(top: 30),
          child: el,
        )).toList(),
      ),
    );
  }
}

class DatasetInputSection extends StatefulWidget {
  const DatasetInputSection({super.key});

  @override
  State<DatasetInputSection> createState() => _DatasetInputSectionState();
}

class _DatasetInputSectionState extends State<DatasetInputSection> {
  String _name = "";
  String? _fileContent;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilePickerButton(
            onSubmit: (fileContent) => _fileContent = fileContent,
          ),
          FixedTextField(
            hintText: 'dataset name',
            onChanged: (val) => _name = val
          )
        ],
      ),
      _fileContent == null ? const SizedBox() : FilledButton(
          onPressed: () => AppController.of(context)
              .addDataset(_name, _fileContent!, context),
          child: const Text('Dodaj Dataset')
      )
    ],
  );
}
