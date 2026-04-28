// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageUpload extends StatefulWidget {
//   const ImageUpload({super.key});

//   @override
//   State<ImageUpload> createState() => _ImageUploadState();
// }

// class _ImageUploadState extends State<ImageUpload> {
//   File? _image; // لتخزين الصورة المختارة
//   final ImagePicker _picker = ImagePicker();
//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path); // تحويل XFile إلى File
//       });
//     }
//   }

//   // نافذة الخيارات (Bottom Sheet)
//   void showImageSourceActionSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Choose from Gallery'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   _pickImage(); // استدعاء دالة اختيار الصورة
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text('Take a Photo'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   // يمكنك إضافة دالة لالتقاط صورة باستخدام الكاميرا هنا
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
