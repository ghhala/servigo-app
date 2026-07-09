
class AdminItem {
  final int adminId;
  final String adminName;
  final String? adminPhoto;
  final int? adminChatId; 

  AdminItem({
    required this.adminId,
    required this.adminName,
    this.adminPhoto,
    this.adminChatId,
  });

  factory AdminItem.fromJson(Map<String, dynamic> json) {
    return AdminItem(
      adminId: json['admin_id'] as int? ?? 0,
      adminName: json['admin_name'] as String? ?? '',
      adminPhoto: json['admin_photo'] as String?,
      adminChatId: json['admin_chat_id'] as int?,
    );
  }
}


class AdminChatMessage {
  final int id;
  final String senderType; // 'user' أو 'admin'
  final int senderId;
  final String? content;
  final String? imageUrl;
  final String? videoUrl;
  final String createdAt;
  final String time;
  final String date;
  final bool isMine;

  AdminChatMessage({
    required this.id,
    required this.senderType,
    required this.senderId,
    this.content,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    required this.time,
    required this.date,
    required this.isMine,
  });

  factory AdminChatMessage.fromJson(Map<String, dynamic> json) {
    return AdminChatMessage(
      id: json['id'] as int? ?? 0,
      senderType: json['sender_type'] as String? ?? 'user',
      senderId: json['sender_id'] as int? ?? 0,
      content: json['content'] as String?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      time: json['time'] as String? ?? '',
      date: json['date'] as String? ?? '',
      isMine: json['is_mine'] as bool? ?? false,
    );
  }
}