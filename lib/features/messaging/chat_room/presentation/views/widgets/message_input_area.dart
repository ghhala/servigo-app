import 'package:flutter/material.dart';

class MessageInputArea extends StatefulWidget {
  const MessageInputArea({Key? key}) : super(key: key);

  @override
  State<MessageInputArea> createState() => _MessageInputAreaState();
}

class _MessageInputAreaState extends State<MessageInputArea> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      color: Colors.transparent, // لجعلها تتناغم مع خلفية الشاشة المتدرجة
      child: Row(
        children: [
          // أيقونة إرفاق ملف (الـ Paperclip)
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.grey, size: 28),
            onPressed: () {
              // هنا تضع وظيفة اختيار الصور أو الملفات
            },
          ),

          // حقل إدخال النص داخل Container لإعطائه الشكل الدائري واللون الرمادي
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200], // لون خلفية الحقل
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message..",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: InputBorder.none, // إزالة الحدود الافتراضية
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // زر الإرسال (الدائري)
          GestureDetector(
            onTap: () {
              if (_controller.text.isNotEmpty) {
                print("Sending: ${_controller.text}");
                _controller.clear(); // مسح النص بعد الإرسال
              }
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF4FC3F7), // اللون الأزرق السماوي من التصميم
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded, // أيقونة الإرسال
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}