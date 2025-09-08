import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePicker();
  }
}

class _UserImagePicker extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 600,
    );

    if (image == null) return;

    setState(() {
      _pickedImage = File(image.path);
    });

    widget.onPickImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage!)
              : null,
          backgroundColor: Colors.grey,
          radius: 50,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          label: Text('Add Image'),
          icon: Icon(Icons.image_rounded),
        ),
      ],
    );
  }
}
