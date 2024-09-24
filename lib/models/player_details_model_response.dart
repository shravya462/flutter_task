class PlayerDetailsModelResponse {
  int? statusCode;
  String? message;
  PlayerDetails? data;

  PlayerDetailsModelResponse({this.statusCode, this.message, this.data});

  PlayerDetailsModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data =
        json['data'] != null ? new PlayerDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PlayerDetails {
  PeriodicScore? periodicScore;
  String? sId;
  String? name;
  String? age;
  String? bestPerformance;
  int? wickets;
  String? photoUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PlayerDetails(
      {this.periodicScore,
      this.sId,
      this.name,
      this.age,
      this.bestPerformance,
      this.wickets,
      this.photoUrl,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PlayerDetails.fromJson(Map<String, dynamic> json) {
    periodicScore = json['periodicScore'] != null
        ? new PeriodicScore.fromJson(json['periodicScore'])
        : null;
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    bestPerformance = json['bestPerformance'];
    wickets = json['wickets'];
    photoUrl = json['photoUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.periodicScore != null) {
      data['periodicScore'] = this.periodicScore!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['bestPerformance'] = this.bestPerformance;
    data['wickets'] = this.wickets;
    data['photoUrl'] = this.photoUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PeriodicScore {
  int? daily;
  int? yearly;

  PeriodicScore({this.daily, this.yearly});

  PeriodicScore.fromJson(Map<String, dynamic> json) {
    daily = json['daily'];
    yearly = json['yearly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily'] = this.daily;
    data['yearly'] = this.yearly;
    return data;
  }
}
