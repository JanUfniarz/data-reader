import 'package:data_reader_client/widgets/dataset_input_section.dart';
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