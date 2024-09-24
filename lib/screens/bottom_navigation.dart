import 'package:flutter/material.dart';
import 'package:flutter_task/models/player_details_model_response.dart';
import 'package:flutter_task/screens/cricket_player_form_screen.dart';
import 'package:flutter_task/screens/players_list_screen.dart';
import 'package:flutter_task/screens/stadium_image_screen.dart';

class BottomNavScreenScreen extends StatefulWidget {
  final int currentIndex;
  const BottomNavScreenScreen({super.key, required this.currentIndex});

  @override
  BottomNavScreenScreenState createState() => BottomNavScreenScreenState();
}

class BottomNavScreenScreenState extends State<BottomNavScreenScreen> {
  int _currentIndex = 0;
  final bottomNavKey = GlobalKey();
  final List<Widget> _pages = [
    PlayerListScreen(),
    CricketPlayerForm(PlayerDetails(), false),
    StadiumImageScreen(),
  ];

  @override
  void initState() {
    setState(() {
      _currentIndex = widget.currentIndex;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.107,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        key: bottomNavKey,
        child: Column(
          children: [
            Container(
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomNavItem(
                  title: "",
                  icon: Icons.home,
                  isSelected: _currentIndex == 0,
                  onTap: () {
                    if (_currentIndex != 0) {
                      setState(
                        () {
                          _currentIndex = 0;
                        },
                      );
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if (_currentIndex != 1) {
                      setState(
                        () {
                          _currentIndex = 1;
                        },
                      );
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              _currentIndex == 1 ? Colors.amber : Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.add,
                        color:
                            _currentIndex == 1 ? Colors.amber : Colors.black),
                  ),
                ),
                bottomNavItem(
                  title: "",
                  icon: Icons.camera,
                  isSelected: _currentIndex == 2,
                  onTap: () {
                    if (_currentIndex != 2) {
                      setState(
                        () {
                          _currentIndex = 2;
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNavItem({
    required String title,
    required IconData icon,
    required bool isSelected,
    GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isSelected
              ? Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 3, color: Colors.amber),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    color: Colors.amber,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    color: Colors.black,
                  ),
                ),
        ],
      ),
    );
  }
}
