import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageInputArea extends StatefulWidget {
  final Function(String content) onSendMessage;
  final Function(File image)? onSendImage;

  const MessageInputArea({
    Key? key,
    required this.onSendMessage,
    this.onSendImage,
  }) : super(key: key);

  @override
  State<MessageInputArea> createState() => _MessageInputAreaState();
}

class _MessageInputAreaState extends State<MessageInputArea> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked =
        await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null && widget.onSendImage != null) {
      widget.onSendImage!(File(picked.path));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      color: Colors.transparent,
      child: Row(
        children: [
          // ✅ زر إرفاق صورة
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.grey, size: 28),
            onPressed: _pickImage,
          ),

          // حقل الإدخال
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message..",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ✅ زر الإرسال
          GestureDetector(
            onTap: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty) {
                widget.onSendMessage(text);
                _controller.clear();
              }
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF4FC3F7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
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