import 'package:flutter/material.dart';
import 'package:flutter_task/models/player_model_response.dart.dart';
import 'package:flutter_task/providers/player_provider.dart';
import 'package:flutter_task/screens/cricket_player_form_screen.dart';
import 'package:provider/provider.dart';

class PlayerDetailScreen extends StatelessWidget {
  final PlayersData player;

  const PlayerDetailScreen({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayerProvider>(context, listen: false)
          .fetchPlayersById(player.sId ?? "");
    });
    String capitalizeFirstLetter(String? name) {
      if (name == null || name.isEmpty) return 'Player Name';
      return name[0].toUpperCase() + name.substring(1);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PlayerProvider>(
        builder: (context, playerProvider, child) {
          return playerProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            playerProvider.playersDetails?.photoUrl ?? "",
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Player's Name
                      Text(
                        capitalizeFirstLetter(
                            playerProvider.playersDetails?.name ??
                                'Player Name'),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Age: ${playerProvider.playersDetails?.age ?? '-'}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),

                      const Divider(
                        height: 40,
                        thickness: 1,
                        color: Colors.black,
                      ),

                      _buildStatRow(
                        icon: Icons.score,
                        label: 'Daily Score',
                        value:
                            '${playerProvider.playersDetails?.periodicScore?.daily ?? 0}',
                      ),

                      _buildStatRow(
                        icon: Icons.calendar_today,
                        label: 'Yearly Score',
                        value:
                            '${playerProvider.playersDetails?.periodicScore?.yearly ?? 0}',
                      ),

                      _buildStatRow(
                        icon: Icons.star,
                        label: 'Best Performance',
                        value: playerProvider.playersDetails?.bestPerformance ??
                            '-',
                      ),

                      _buildStatRow(
                        icon: Icons.sports_cricket,
                        label: 'Wickets',
                        value: '${playerProvider.playersDetails?.wickets ?? 0}',
                      ),
                      const SizedBox(height: 100),

                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => CricketPlayerForm(player, true),
                            ),
                          );
                        },
                        label: const Text(
                          'Edit Details',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildStatRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
