class ExperiencesModel {
  ExperiencesModel({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.title,
    required this.description,
    required this.statusId,
    required this.price,
    required this.createdAt,
    required this.statusName,
    required this.image,

    //required this.assets,
  });

  int id;
  int playerId;
  String playerName;
  String title;
  String description;
  int statusId;
  String price;
  String createdAt;
  String statusName;
  String image;

  //Assets assets;

  /* factory NewsModelDatum.fromJson(Map<String, dynamic> json) => NewsModelDatum(
        id: json["id"],
        playerId: json["player_id"],
        playerName: json["player_name"],
        title: json["title"],
        description: json["description"],
        statusId: json["status_id"],
        statusName: json["status_name"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        assets: Assets.fromJson(json["Assets"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "player_id": playerId,
        "player_name": playerName,
        "title": title,
        "description": description,
        "status_id": statusId,
        "status_name": statusName,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "Assets": assets.toJson(),
    }; */
}
