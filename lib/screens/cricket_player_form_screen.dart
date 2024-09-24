import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/player_model_response.dart.dart';
import 'package:flutter_task/providers/profile_form_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CricketPlayerForm extends StatefulWidget {
  final PlayersData player;
  final bool isEdit;
  const CricketPlayerForm(this.player, this.isEdit);

  @override
  _CricketPlayerFormState createState() => _CricketPlayerFormState();
}

class _CricketPlayerFormState extends State<CricketPlayerForm> {
  void _submitForm(BuildContext context) {
    widget.isEdit
        ? Provider.of<ProfileFormProvider>(context, listen: false)
            .updatePlayer(context, widget.player.sId ?? "")
        : Provider.of<ProfileFormProvider>(context, listen: false)
            .createPlayer();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileFormProvider>(context, listen: false).imageFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileFormProvider>(
        builder: (context, profileProvider, child) {
      profileProvider.nameController.text = widget.player.name ?? '';
      profileProvider.ageController.text = widget.player.age?.toString() ?? '';
      profileProvider.totalDayScoreController.text =
          widget.player.periodicScore?.daily?.toString() ?? '';
      profileProvider.totalYearScoreController.text =
          widget.player.periodicScore?.yearly?.toString() ?? '';
      profileProvider.wicketController.text =
          widget.player.wickets?.toString() ?? '';
      profileProvider.bestPerformanceController.text =
          widget.player.bestPerformance ?? '';

      profileProvider.imagePath = widget.player.photoUrl ?? "";
      debugPrint(
          "dhshdhsg${profileProvider.imagePath}----${widget.player.photoUrl ?? ""}");
      return Scaffold(
        appBar: AppBar(
          leading: widget.isEdit
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                )
              : SizedBox.shrink(),
          title: Text('Cricket Player Form'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(21, 10, 31, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    profileProvider.pickImage(context, ImageSource.gallery);
                  },
                  child: profileProvider.imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            profileProvider.imageFile!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const CircleAvatar(
                                radius: 50,
                              );
                            },
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            profileProvider.imagePath ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    profileProvider.imageFile?.path ?? ""),
                                child: Image.network(
                                  profileProvider.imageFile?.path ?? "",
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 30),

              // Using the reusable widget function for multiple fields
              buildTextField(
                title: 'Name',
                controller: profileProvider.nameController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),

              buildTextField(
                title: 'Age',
                controller: profileProvider.ageController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              buildTextField(
                title: 'Total Day Score',
                controller: profileProvider.totalDayScoreController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              buildTextField(
                title: 'Total Yearly Score',
                controller: profileProvider.totalYearScoreController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              buildTextField(
                title: 'Wickets',
                controller: profileProvider.wicketController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              buildTextField(
                title: 'Best Performance',
                controller: profileProvider.bestPerformanceController,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 50),

              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 140,
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }

  Widget buildTextField({
    required String title,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
