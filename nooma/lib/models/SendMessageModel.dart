class MessageModel {
  final String messageID;
  final String username;
  final String messageContent;
  final String sendDate;

  MessageModel(this.messageID, this.username, this.messageContent, this.sendDate);

  MessageModel.fromJson(Map<String, dynamic> json)
      : messageID = json['messageID'].toString(),
        username = json['username'],
        messageContent = json['messageContent'],
        sendDate = json['sendDate'];

  Map<String, dynamic> toJson() =>
      {
        'messageID': messageID,
        'username': username,
        'messageContent': messageContent,
        'sendDate': sendDate,
      };
}