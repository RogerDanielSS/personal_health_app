import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class FilePickerExample extends StatefulWidget {
  const FilePickerExample({super.key});

  @override
  State<FilePickerExample> createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  String? _fileName;
  Uint8List? _fileBytes;
  String? _fileExtension;
  int? _fileSize;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        setState(() {
          _fileName = file.name;
          _fileBytes = file.bytes;
          _fileExtension = file.extension;
          _fileSize = file.size;
        });

        // You can now use _fileBytes (Uint8List) for your purposes
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickFile,
            child: const Text('Pick File'),
          ),
          const SizedBox(height: 20),
          if (_fileName != null) ...[
            Text('File Name: $_fileName'),
            Text('Extension: $_fileExtension'),
            Text('Size: ${_fileSize ?? 0} bytes'),
            if (_fileBytes != null)
              Text('Bytes loaded: ${_fileBytes!.length} bytes'),
          ],
        ],
      ),
    );
  }
}
