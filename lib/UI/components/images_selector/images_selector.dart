import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:personal_health_app/UI/components/images_carousel/images_carousel.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';

class ImagesSelector extends StatefulWidget {
  final void Function() handleSelectFiles;
  final List<LocalFileEntity> files;

  const ImagesSelector({
    super.key,
    required this.handleSelectFiles,
    required this.files,
  });

  @override
  State<ImagesSelector> createState() => _ImagesSelectorState();
}

class _ImagesSelectorState extends State<ImagesSelector> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show carousel if there are files, otherwise show the file picker button
          if (widget.files.isNotEmpty) ...[
            ImagesCarousel(files: widget.files)
          ] else ...[
            _buildNoFileSelected(),
          ],

          const SizedBox(height: 20),
          _buildSelectFilesButton(),
        ],
      ),
    );
  }

  Widget _buildNoFileSelected() {
    return InkWell(
      onTap: widget.handleSelectFiles,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 500,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double iconSize = constraints.maxWidth * 0.4;
            double constrainedIconSize = iconSize.clamp(24.0, 200.0);

            return Icon(
              Icons.image,
              size: constrainedIconSize,
              color: Colors.grey,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectFilesButton() {
    return ElevatedButton.icon(
      onPressed: widget.handleSelectFiles,
      icon: const Icon(Icons.add_photo_alternate),
      label: const Text('Adicionar'),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
