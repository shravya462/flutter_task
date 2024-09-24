import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/providers/player_provider.dart';
import 'package:flutter_task/screens/components/fluttertoast.dart';
import 'package:flutter_task/utils/base_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileFormProvider extends ChangeNotifier {
  final BaseClient apiService = BaseClient();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _totalDayScoreController =
      TextEditingController();
  final TextEditingController _totalYearScoreController =
      TextEditingController();
  final TextEditingController _wicketController = TextEditingController();
  final TextEditingController _bestPerformanceController =
      TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  File? _imageFile;
  String? _imagePath;

  // Getter
  String? get imagePath => _imagePath;
  File? get imageFile => _imageFile;
  TextEditingController get nameController => _nameController;
  TextEditingController get ageController => _ageController;
  TextEditingController get totalDayScoreController => _totalDayScoreController;
  TextEditingController get totalYearScoreController =>
      _totalYearScoreController;
  TextEditingController get wicketController => _wicketController;
  TextEditingController get bestPerformanceController =>
      _bestPerformanceController;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Setter
  set imagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }

  set imageFile(val) {
    _imageFile = val;
    notifyListeners();
  }

  // Pick an image from gallery or camera
  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _imagePath = _imageFile!.path;
      debugPrint("Image Path: ${_imageFile!.path}");
      debugPrint("Image Name: ${_imageFile?.path.split('/').last ?? " "}");
      notifyListeners();
    }
  }

  // Edit profile details and upload the image if available

  Future<void> createPlayer() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.postData('/api/players', {
        "name": _nameController.text,
        "age": _ageController.text,
        "periodicScore": {
          "daily": int.tryParse(_totalDayScoreController.text) ?? 0,
          "yearly": int.tryParse(_totalYearScoreController.text) ?? 0,
        },
        "bestPerformance": _bestPerformanceController.text,
        "wickets": int.tryParse(_wicketController.text) ?? 0,
        if (imageFile != null)
          'photoUrl': [
            await MultipartFile.fromFile(imageFile!.path,
                filename: _imageFile?.path.split('/').last ?? ""),
          ]
      });

      if (response.statusCode == 201) {
        ToastHelper.showToast(
          "Saved Successfully",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        _nameController.clear();
        _ageController.clear();
        _totalDayScoreController.clear();
        _totalYearScoreController.clear();
        _bestPerformanceController.clear();
        _wicketController.clear();

        _isLoading = false;
        notifyListeners();
      } else {
        ToastHelper.showToast(
          'Something went wrong!',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        _isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      ToastHelper.showToast(
        '${error}',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePlayer(BuildContext context, String playerId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.putData('api/players/$playerId', {
        "name": _nameController.text,
        "age": _ageController.text,
        "periodicScore": {
          "daily": int.tryParse(_totalDayScoreController.text) ?? 0,
          "yearly": int.tryParse(_totalYearScoreController.text) ?? 0,
        },
        "bestPerformance": _bestPerformanceController.text.trim(),
        "wickets": int.tryParse(_wicketController.text) ?? 0,
        "photoUrl": imageFile == null
            ? _imagePath
            : [
                await MultipartFile.fromFile(imageFile!.path,
                    filename: _imageFile?.path.split('/').last ?? ""),
              ]
      });

      if (response.statusCode == 200) {
        ToastHelper.showToast(
          "Updated Successfully",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<PlayerProvider>(context, listen: false)
              .fetchPlayersById(playerId);
        });
        Navigator.pop(context);
        _isLoading = false;
        notifyListeners();
      } else {
        ToastHelper.showToast(
          'Something went wrong!',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        _isLoading = false;
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      ToastHelper.showToast(
        '${error}',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
