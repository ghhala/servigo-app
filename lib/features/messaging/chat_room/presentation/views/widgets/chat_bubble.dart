import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe; // true إذا كانت الرسالة مرسلة مني، false إذا كانت مستلمة

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.5,
            height: 1.3, // تباعد الأسطر لراحة العين
          ),
        ),
      ),
    );
  }
}