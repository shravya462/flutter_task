import 'package:flutter/material.dart';

import 'package:flutter_task/models/player_details_model_response.dart';
import 'package:flutter_task/models/player_model_response.dart.dart';
import 'package:flutter_task/screens/components/fluttertoast.dart';
import 'package:flutter_task/utils/base_client.dart';

class PlayerProvider with ChangeNotifier {
  final BaseClient apiService = BaseClient();
  List<PlayersData> _players = [];
  PlayerDetails? _playersDetails;
  bool _isLoading = false;
  List<PlayersData> get players => _players;
  PlayerDetails? get playersDetails => _playersDetails;
  bool get isLoading => _isLoading;

//GET PLAYERS LIST API

  Future<void> fetchPlayers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.getData('api/players/getall');

      var playerResponse = PlayerDataModelResponse.fromJson(response.data);
      _players = playerResponse.data ?? [];

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error fetching players: $error');
      _isLoading = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  //GET PLAYERS LIST API

  Future<void> fetchPlayersById(String playerId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.getData('api/players/$playerId');

      var playerResponse = PlayerDetailsModelResponse.fromJson(response.data);
      _playersDetails = playerResponse.data;

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error fetching players: $error');
      _isLoading = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

//DELETE PLAYER FROM LIST API

  Future<void> deletePlayer(String playerId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await apiService.deleteData('api/players/delete/$playerId');
      ToastHelper.showToast(
        "Deleted Successfully",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      await fetchPlayers();
    } catch (error) {
      print('Error deleting players: $error');
      _isLoading = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchPlayer(String query) {
    if (query.isEmpty) {
      fetchPlayers();
    } else {
      _players = _players
          .where((player) =>
              player.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
}
