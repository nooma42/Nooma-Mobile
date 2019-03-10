class JoinRoomModel {
  final String status;
  final String roomID;


  JoinRoomModel(this.status, this.roomID);

  JoinRoomModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        roomID = json['roomID'].toString();

  Map<String, dynamic> toJson() =>
      {
        'status': status,
        'roomID': roomID,
      };
}

