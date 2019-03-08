class ChannelModel {
  final String channelID;
  final String channelName;


  ChannelModel(this.channelID, this.channelName);

  ChannelModel.fromJson(Map<String, dynamic> json)
      : channelID = json['channelID'].toString(),
        channelName = json['channelName'];

  Map<String, dynamic> toJson() =>
      {
        'channelID': channelID,
        'channelName': channelName,
      };
}

