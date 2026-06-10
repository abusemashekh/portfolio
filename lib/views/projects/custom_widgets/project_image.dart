import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/project_model.dart';

class ProjectImageSection extends StatelessWidget {
  final ProjectModel project;
  final bool isMobile;

  const ProjectImageSection({
    super.key,
    required this.project,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (project.images == null || project.images!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: isMobile ? 180 : 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.purple],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: project.images!.length > 1
          ? MultipleImagesView(
              images: project.images!,
              isMobile: isMobile,
            )
          : SingleImageView(
              imagePath: project.images!.first,
              isMobile: isMobile,
            ),
    );
  }
}

class MultipleImagesView extends StatelessWidget {
  final List<String> images;
  final bool isMobile;

  const MultipleImagesView({
    super.key,
    required this.images,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: images.map((image) {
        final imageCount = images.length;
        final containerWidth = MediaQuery.of(context).size.width - 24;
        final availableWidth = containerWidth * 0.9;
        final calculatedWidth = availableWidth / imageCount;
        final imageWidth = calculatedWidth.clamp(40, 80);
        final imageHeight = (isMobile ? 140 : 160).toDouble();

        return ProjectImageItem(
          imagePath: image,
          width: imageWidth.toDouble(),
          height: imageHeight,
          isMobile: isMobile,
        );
      }).toList(),
    );
  }
}

class SingleImageView extends StatelessWidget {
  final String imagePath;
  final bool isMobile;

  const SingleImageView({
    super.key,
    required this.imagePath,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return ImageErrorPlaceholder(isMobile: isMobile);
        },
      ),
    );
  }
}

class ProjectImageItem extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final bool isMobile;

  const ProjectImageItem({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ImageErrorPlaceholder(isMobile: isMobile);
          },
        ),
      ),
    );
  }
}

// Image error placeholder
class ImageErrorPlaceholder extends StatelessWidget {
  final bool isMobile;

  const ImageErrorPlaceholder({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Colors.grey[700]!,
            Colors.grey[800]!,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image_not_supported,
          color: Colors.grey[500],
          size: isMobile ? 20 : 24,
        ),
      ),
    );
  }
}
