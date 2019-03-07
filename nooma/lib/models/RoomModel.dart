class RoomModel {
  final String roomID;
  final String roomName;
  final String eventDate;
  final String host;

  RoomModel(this.roomID, this.roomName, this.eventDate, this.host);

  RoomModel.fromJson(Map<String, dynamic> json)
      : roomID = json['roomID'].toString(),
        roomName = json['roomName'],
        eventDate = json['eventDate'],
        host = json['host'];

  Map<String, dynamic> toJson() =>
      {
        'roomID': roomID,
        'roomName': roomName,
        'eventDate': eventDate,
        'host': host,
      };
}
