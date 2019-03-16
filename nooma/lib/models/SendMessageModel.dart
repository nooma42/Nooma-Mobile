class SendMessageModel {
  final String userID;
  final String messageContent;
  final String sendDate;

  SendMessageModel(this.userID, this.messageContent, this.sendDate);

  SendMessageModel.fromJson(Map<String, dynamic> json)
      : userID = json['userID'].toString(),
        messageContent = json['messageContent'],
        sendDate = json['sendDate'];

  Map<String, dynamic> toJson() =>
      {
        'userID': userID,
        'messageContent': messageContent,
        'sendDate': sendDate,
      };
}