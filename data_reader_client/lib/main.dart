import 'package:data_reader_client/style/default_theme.dart';
import 'package:flutter/material.dart';

import 'file_picker.dart';

main() => runApp(MaterialApp(
  theme: defaultTheme,
  home: const ReaderClient(),
));
    
class ReaderClient extends StatelessWidget {
  const ReaderClient({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const FilePicker(),
            OutlinedButton(
                onPressed: () {},
                child: const Text("Model: gemma3")
            )
          ],
        ),
        const Divider()
      ].map((el) => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: el,
      )).toList(),
    ),
  );
}
    