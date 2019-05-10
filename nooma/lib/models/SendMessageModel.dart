import 'dart:convert' show utf8;

class SendMessageModel {
  final String userID;
  final String channelID;
  final String messageContent;
  final String sendDate;
  final String isAnonymous;

  SendMessageModel(this.userID, this.channelID, this.messageContent, this.sendDate, this.isAnonymous);

  SendMessageModel.fromJson(Map<String, dynamic> json)
      : userID = json['userID'].toString(),
        channelID = json['channelID'].toString(),
        messageContent = json['messageContent'],
        sendDate = json['sendDate'],
        isAnonymous = json['isAnonymous'];

  Map<String, dynamic> toJson() =>
      {
        'userID': userID,
        'channelID': channelID,
        'messageContent': messageContent,
        'sendDate': sendDate,
        'isAnonymous' : isAnonymous,
      };
}