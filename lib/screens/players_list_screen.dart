import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import 'components/player_list_item.dart';

class PlayerListScreen extends StatefulWidget {
  @override
  _PlayerListScreenState createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<PlayerProvider>(context, listen: false).fetchPlayers();
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cricket Players'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<PlayerProvider>(context, listen: false)
                  .fetchPlayers();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Search Player',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                Provider.of<PlayerProvider>(context, listen: false)
                    .searchPlayer(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<PlayerProvider>(
              builder: (context, provider, child) {
                debugPrint('apiCallresponse:${provider.players.length}');
                return provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.players.isEmpty
                        ? const Center(child: Text('No players found.'))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            itemCount: provider.players.length,
                            itemBuilder: (ctx, index) => PlayerListItem(
                              player: provider.players[index],
                            ),
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}
