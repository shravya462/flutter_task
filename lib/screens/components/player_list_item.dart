import 'package:flutter/material.dart';
import 'package:flutter_task/models/player_model_response.dart.dart';
import 'package:flutter_task/providers/player_provider.dart';
import 'package:provider/provider.dart';
import '../player_detail_screen.dart';

class PlayerListItem extends StatelessWidget {
  final PlayersData player;

  const PlayerListItem({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(player.photoUrl ?? ""),
        ),
        title: Text(
          player.name ?? "",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          'Age: ${player.age}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlayerDetailScreen(
                player: player,
              ),
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<PlayerProvider>(context, listen: false)
                .deletePlayer(player.sId ?? "");
          },
        ),
      ),
    );
  }
}
