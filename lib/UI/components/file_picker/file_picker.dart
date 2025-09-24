import 'package:flutter/material.dart';

class FilePickerExample extends StatefulWidget {
  final Widget child;
  final void Function() handleSelectFiles;

  const FilePickerExample(
      {super.key, required this.child, required this.handleSelectFiles});

  @override
  State<FilePickerExample> createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: widget.handleSelectFiles,
            child: widget.child,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
