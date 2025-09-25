import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';

class ImagesCarousel extends StatefulWidget {
  final List<LocalFileEntity> files;

  const ImagesCarousel({
    super.key,
    required this.files,
  });

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  int _currentIndex = 0;

  void _openFullScreen(int startIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenCarousel(
          files: widget.files,
          initialIndex: startIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 500,
          ),
          child: CarouselSlider.builder(
            itemCount: widget.files.length,
            options: CarouselOptions(
              height: (MediaQuery.of(context).size.width * 0.8)
                  .clamp(0, 500)
                  .toDouble(),
              aspectRatio: 1.0,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              enableInfiniteScroll: widget.files.length > 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final file = widget.files[index];
              return GestureDetector(
                onTap: () => _openFullScreen(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: _buildImageWidget(file),
                  ),
                ),
              );
            },
          ),
        ),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildImageWidget(LocalFileEntity file) {
    if (file.bytes != null) {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderIcon();
        },
      );
    } else if (file.filePath != null) {
      return Image.asset(
        file.filePath!,
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
            color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}

class FullScreenCarousel extends StatefulWidget {
  final List<LocalFileEntity> files;
  final int initialIndex;

  const FullScreenCarousel({
    super.key,
    required this.files,
    required this.initialIndex,
  });

  @override
  State<FullScreenCarousel> createState() => _FullScreenCarouselState();
}

class _FullScreenCarouselState extends State<FullScreenCarousel> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.files.length}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.files.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final file = widget.files[index];
              return InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 3.0,
                child: _buildFullScreenImage(file),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFullScreenImage(LocalFileEntity file) {
    if (file.bytes != null) {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildFullScreenPlaceholder();
        },
      );
    } else if (file.filePath != null) {
      return Image.asset(
        file.filePath!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildFullScreenPlaceholder();
        },
      );
    } else {
      return _buildFullScreenPlaceholder();
    }
  }

  Widget _buildFullScreenPlaceholder() {
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: Icon(
          Icons.image,
          size: 100,
          color: Colors.grey,
        ),
      ),
    );
  }
}