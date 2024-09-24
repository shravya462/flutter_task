// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_task/utils/db_helper.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/captured_image.dart';


// class ImageProvider extends ChangeNotifier {
//   final List<CapturedImage> _images = [];

//   List<CapturedImage> get images => _images;

//   Future<void> captureImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       final newImage = CapturedImage(
//         id: DateTime.now().millisecondsSinceEpoch,
//         imagePath: pickedFile.path,
//         dateCaptured: DateTime.now().toIso8601String().substring(0, 10), // YYYY-MM-DD format
//       );

//       await DBHelper.insertImage(newImage);
//       _images.add(newImage);
//       notifyListeners();
//     }
//   }

//   Future<void> fetchImages({String? date}) async {
//     final fetchedImages = await DBHelper.fetchImages(date: date);
    
//     // Clear and add all images to the list; using `toList()` or `.toIterable()` to ensure proper type assignment
//     _images.clear();
//     _images.addAll(fetchedImages.toList()); // Adding to list as Iterable if needed
    
//     notifyListeners();
//   }
// }
