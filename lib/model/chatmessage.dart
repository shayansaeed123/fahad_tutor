class ChatMessage {
  final String id;
  final String meetingId;
  final String message;
  final String datetime;
  final String senderId;
  final String role;
  final bool isOwn;

  ChatMessage({
    required this.id,
    required this.meetingId,
    required this.message,
    required this.datetime,
    required this.senderId,
    required this.role,
    required this.isOwn,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      meetingId: json['meeting_id'] ?? '',
      message: json['remarks'] ?? '',
      datetime: json['datetime'] ?? '',
      senderId: json['sender_id'] ?? '',
      role: json['role'] ?? '',
      isOwn: json['is_own'] == 1,
    );
  }
}
