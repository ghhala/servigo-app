import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String? imageUrl;
  final String? videoUrl;
  final String? time;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
    this.imageUrl,
    this.videoUrl,
    this.time,
  }) : super(key: key);

 
  String _buildImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    if (path.contains('localhost')) {
      return path.replaceAll('localhost', '10.0.2.2');
    }
    return 'http://10.0.2.2/servigo/public$path';
  }

  @override
  Widget build(BuildContext context) {
    final fullImageUrl = _buildImageUrl(imageUrl);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF7E57C2) : const Color(0xFF4FC3F7),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ✅ صورة مع URL كامل
            if (fullImageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  fullImageUrl,
                  width: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      width: 200,
                      height: 150,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),

            // ✅ نص الرسالة
            if (message.isNotEmpty)
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  height: 1.3,
                ),
              ),

            // ✅ وقت الرسالة
            if (time != null) ...[
              const SizedBox(height: 4),
              Text(
                time!,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}