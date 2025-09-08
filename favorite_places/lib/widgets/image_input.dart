import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectImage});

  final void Function(File) onSelectImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  ImageSource lastImageSource = ImageSource.camera;

  void _takePicture(ImageSource imageSource) async {
    lastImageSource = imageSource;

    final pickedImage = await ImagePicker().pickImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.rear,

      // maxWidth: 600,
    );

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onSelectImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
          onPressed: () => _takePicture(ImageSource.camera),
          label: Text('Take Picture'),
          icon: Icon(Icons.camera_alt),
        ),
        TextButton.icon(
          onPressed: () => _takePicture(ImageSource.gallery),
          label: Text('Pick from Gallery'),
          icon: Icon(Icons.photo_album),
        ),
      ],
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () => _takePicture(lastImageSource),
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }

    return Container(
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(50),
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
