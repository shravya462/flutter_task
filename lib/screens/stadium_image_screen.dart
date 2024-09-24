import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../utils/db_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StadiumImageScreen extends StatefulWidget {
  @override
  _StadiumImageScreenState createState() => _StadiumImageScreenState();
}

class _StadiumImageScreenState extends State<StadiumImageScreen> {
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _images = [];
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    final images = await DBHelper.getImages(date: _selectedDate);
    setState(() {
      _images = images;
    });
  }

  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String imagePath = join(appDir.path, basename(pickedFile.path));
      await File(pickedFile.path).copy(imagePath);

      final date = DateTime.now().toIso8601String().split('T')[0];
      await DBHelper.insertImage(imagePath, date);
      _fetchImages();
    }
  }

  void _onDateSelected(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDate = (args.value as DateTime).toIso8601String().split('T')[0];
    });
    _fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stadium Images'),
      ),
      body: Column(
        children: [
          SfDateRangePicker(
            onSelectionChanged: _onDateSelected,
            selectionMode: DateRangePickerSelectionMode.single,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _images.length,
              itemBuilder: (ctx, i) => Image.file(
                File(_images[i]['path']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureImage,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
