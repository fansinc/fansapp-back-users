import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider with ChangeNotifier {
  late PickedFile _image;

  void setImage(PickedFile pickedImage) {
    _image = pickedImage;
    notifyListeners();
  }

  PickedFile get fetchPickedImage {
    return _image;
  }
}
