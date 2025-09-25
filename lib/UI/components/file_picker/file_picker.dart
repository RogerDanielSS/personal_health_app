import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';

class FilePickerExample extends StatefulWidget {
  final void Function() handleSelectFiles;
  final List<LocalFileEntity> files;

  const FilePickerExample({
    super.key,
    required this.handleSelectFiles,
    required this.files,
  });

  @override
  State<FilePickerExample> createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show carousel if there are files, otherwise show the file picker button
          if (widget.files.isNotEmpty) ...[
            _buildImageCarousel(),
            const SizedBox(height: 16),
            _buildIndicator(),
            const SizedBox(height: 20),
          ] else ...[
            _buildFilePickerButton(),
          ],

          const SizedBox(height: 20),
          _buildSelectFilesButton(),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return CarouselSlider.builder(
      itemCount: widget.files.length,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width * 0.8,
        aspectRatio: 1.0,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        enableInfiniteScroll: widget.files.length > 1,
        // autoPlay: widget.files.length > 1,
        // autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final file = widget.files[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: _buildImageWidget(file),
          ),
        );
      },
    );
  }

  Widget _buildImageWidget(LocalFileEntity file) {
    // Priority: bytes > filePath > placeholder
    if (file.bytes != null) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 500,
          ),
          child: Image.memory(
            file.bytes!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderIcon();
            },
          ));
    } else if (file.filePath != null) {
      return Image.asset(
        file.filePath!, // Use Image.file for actual file paths: FileImage(File(file.filePath!))
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderIcon();
        },
      );
    } else {
      return _buildPlaceholderIcon();
    }
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(
        Icons.image,
        size: 60,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.files.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == entry.key
                ? Colors.blue
                : Colors.grey.withOpacity(0.4),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFilePickerButton() {
    return InkWell(
      onTap: widget.handleSelectFiles,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
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
