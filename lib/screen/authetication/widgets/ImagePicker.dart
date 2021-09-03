import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/PickImageProvider.dart';
class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 60,
            backgroundImage: _pickedImage!=null?FileImage(_pickedImage!):null,
        ),
        ElevatedButton.icon(
            onPressed: pickImage,
            icon: Icon(Icons.image),
            label:Text('Add Image')
        )
      ],
    );
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final image =await _picker.getImage(source: ImageSource.gallery);

    setState((){
      _pickedImage=File(image!.path);
    });
    Provider.of<PickImageProvider>(context,listen: false).updatingImage(_pickedImage);
  }

}
