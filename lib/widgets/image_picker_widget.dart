import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/config/app_config.dart';
import 'package:provider/provider.dart';

import '/providers/image_picker_provider.dart';
import '/config/app_strings.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  PickedFile? _image;
  final picker = ImagePicker();
  Future _getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      //ImageSource.camera,
      imageQuality: 25,
    );
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        //File(pickedFile.path);
      } else {
        //print(AppStrings.noImageSelected);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_image != null) {
      Provider.of<ImagePickerProvider>(context).setImage(_image!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.imagePickerDesc,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _image != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    //height: 200,
                    width: 250,
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: _getImage,
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  ),
                ],
              )
            /* Text(
                  AppStrings.imageSelected,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ) */
            : SizedBox(
                // alignment: Alignment.topLeft,
                height: 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: _getImage,
                  child: const Text(
                    AppStrings.select,
                    style: TextStyle(
                      color: Color(AppConfig.blueColor),
                    ),
                  ),
                ),
              ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
