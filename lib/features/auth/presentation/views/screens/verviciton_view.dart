import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';

class VervicitonView extends StatefulWidget {
  final String userType;
  final Map<String, dynamic> userData;

  const VervicitonView({
    super.key,
    required this.userData,
    required this.userType,
  });

  @override
  State<VervicitonView> createState() => _VervicitonViewState();
}

class _VervicitonViewState extends State<VervicitonView> {
  File? _frontImage;
  File? _backImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, bool isFront) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      });
    }
  }

  void showImageSourceActionSheet(BuildContext context, bool isFront) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(AppLocalizations.of(context)!.chooseFromGallery),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery, isFront);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(AppLocalizations.of(context)!.takePhoto),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera, isFront);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 130.h,
            top: 10.h,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFB38CF5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.uploadIdPhoto,
                      style: TextStyles.font20White800,
                    ),
                    Gap(10.h),
                    Text(
                      AppLocalizations.of(context)!.uploadClearPhoto,
                      textAlign: TextAlign.center,
                      style: TextStyles.font15WhiteColorW500,
                    ),
                    Gap(24.h),
                    GestureDetector(
                      onTap: () => showImageSourceActionSheet(context, true),
                      child: _buildImagePlaceHolder(_frontImage),
                    ),
                    Gap(10.h),
                    Text(
                      AppLocalizations.of(context)!.uploadFrontImage,
                      style: TextStyles.font15WhiteColorW500.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),

                    Gap(30.h),

                    GestureDetector(
                      onTap: () => showImageSourceActionSheet(context, false),
                      child: _buildImagePlaceHolder(_backImage),
                    ),
                    Gap(10.h),
                    Text(
                      AppLocalizations.of(context)!.uploadBackImage,
                      style: TextStyles.font15WhiteColorW500.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),

                    Gap(54.h),
                    CustomButton(
                      title: AppLocalizations.of(context)!.submit,
                      textstyle: TextStyles.font20White800,
                      width: MediaQuery.sizeOf(context).width * 0.60,
                      height: 52.h,
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.kCompliteProfile, extra: {
                          "userType": widget.userType,
                          "userData": widget.userData
                       
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceHolder(File? imageFile) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: imageFile != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(imageFile, fit: BoxFit.cover),
            )
          : Center(child: SvgPicture.asset("assets/images/camera_icon.svg")),
    );
  }
}
