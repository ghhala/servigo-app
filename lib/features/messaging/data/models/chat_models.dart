


class ChatListItem {
  final int id;
  final String type;
  final int otherPartyId;
  final String otherPartyName;
  final String? otherPartyPhoto;
  final String otherPartyRole;
  final String? lastMessage;
  final String? lastMessageTime;

  ChatListItem({
    required this.id,
    required this.type,
    required this.otherPartyId,
    required this.otherPartyName,
    this.otherPartyPhoto,
    required this.otherPartyRole,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ChatListItem.fromJson(Map<String, dynamic> json) {
    final otherParty = json['other_party'] as Map<String, dynamic>? ?? {};
    return ChatListItem(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String? ?? 'private',
      otherPartyId: otherParty['id'] as int? ?? 0,
      otherPartyName: otherParty['name'] as String? ?? '',
      otherPartyPhoto: otherParty['photo'] as String?,
      otherPartyRole: otherParty['role'] as String? ?? 'provider',
      lastMessage: json['last_message'] as String?,
      lastMessageTime: json['last_message_time'] as String?,
    );
  }
}


class ChatMessage {
  final int id;
  final int senderId;
  final String senderName;
  final String? content;
  final String? imageUrl;
  final String? videoUrl;
  final String createdAt;
  final String time;
  final String date;
  final bool isMine;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.content,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    required this.time,
    required this.date,
    required this.isMine,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as int? ?? 0,
      senderId: json['sender_id'] as int? ?? 0,
      senderName: json['sender_name'] as String? ?? '',
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


class StartChatResponse {
  final int chatId;
  final bool isExisting;

  StartChatResponse({required this.chatId, required this.isExisting});

  factory StartChatResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return StartChatResponse(
      chatId: data['chat_id'] as int? ?? 0,
      isExisting: data['is_existing'] as bool? ?? false,
    );
  }
}


class ChatOtherParty {
  final int id;
  final String name;
  final String? photo;

  ChatOtherParty({required this.id, required this.name, this.photo});

  factory ChatOtherParty.fromJson(Map<String, dynamic> json) {
    return ChatOtherParty(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      photo: json['photo'] as String?,
    );
  }
}