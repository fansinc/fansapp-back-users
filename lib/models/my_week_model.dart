class MyWeekModel {
  MyWeekModel({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.statusId,
    required this.statusName,
    required this.image,
  });

  int id;
  int playerId;
  String playerName;
  int statusId;
  String statusName;
  List<String> image;
}
