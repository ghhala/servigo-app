import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/user_profile/presentation/view_models/edit_profile/edit_profile_cubit.dart';
import 'package:servi_go_app/features/user_profile/presentation/view_models/edit_profile/edit_profile_state.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class EditProfileUser extends StatefulWidget {
  final String? currentName;
  final String? currentPhone;

  const EditProfileUser({
    super.key, 
    this.currentName, 
    this.currentPhone,
  });

  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  final TextEditingController _emailController = TextEditingController();

  File? _pickedImage; 
  bool _isImageLoading = false; 

  late EditProfileCubit _editProfileCubit;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _editProfileCubit = BlocProvider.of<EditProfileCubit>(context);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
      _editProfileCubit.uploadAvatar(imagePath: image.path);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _formatImageUrl(String url) {
    if (url.isEmpty) return '';
    if (url.contains('localhost')) {
      return url.replaceAll('localhost', '10.0.2.2');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
   
    String cachedImageUrl = PrefHelper.getUserImage(); 
    String formattedUrl = _formatImageUrl(cachedImageUrl);

    String firstLetter = (widget.currentName != null && widget.currentName!.isNotEmpty)
        ? widget.currentName![0].toUpperCase()
        : "U";

    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(top: 80.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocListener<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.responseModel.message ?? " data updated successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context, true);
              } else if (state is EditProfileFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("خطأ: ${state.errorMessage}"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              
              if (state is UploadAvatarLoading) {
                setState(() {
                  _isImageLoading = true; 
                });
              } else if (state is UploadAvatarSuccess) {
                setState(() {
                  _isImageLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("upload photo successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is UploadAvatarFailure) {
                setState(() {
                  _isImageLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed to upload photo: ${state.errorMessage}"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: (_pickedImage == null && formattedUrl.isEmpty) 
                            ? Colors.deepPurpleAccent 
                            : const Color(0xFFF3F2F2),
                        
                      
                        backgroundImage: _pickedImage != null 
                            ? FileImage(_pickedImage!) 
                            : (formattedUrl.isNotEmpty 
                                ? NetworkImage('$formattedUrl?v=${DateTime.now().millisecondsSinceEpoch}') 
                                : null),
                        child: (_pickedImage == null && formattedUrl.isEmpty)
                            ? Text(
                                firstLetter, 
                                style: TextStyle(
                                  fontSize: 36.sp, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4.w,
                        child: GestureDetector(
                          onTap: _isImageLoading ? null : _pickImage, 
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: _isImageLoading
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.h,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  Container(
                    width: 353.w,
                    height: 380.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Account Info",
                            style: TextStyles.font16BlackW700,
                          ),
                        ),
                        const Divider(color: Colors.black, thickness: 0.8),
                        const Gap(11),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full Name",
                                style: TextStyles.font16PrimaryColorW600,
                              ),
                              CustomTextFormFiled(
                                hintText: "Full Name",
                                controller: _nameController,
                              ),
                              const Gap(15),
                              Text(
                                "Email",
                                style: TextStyles.font16PrimaryColorW600,
                              ),
                              CustomTextFormFiled(
                                hintText: "user@servigo.com",
                                controller: _emailController,
                              ),
                              const Gap(15),
                              Text(
                                "Phone Number",
                                style: TextStyles.font16PrimaryColorW600,
                              ),
                              CustomTextFormFiled(
                                hintText: "Phone Number",
                                controller: _phoneController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      if (state is EditProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      return CustomButton(
                        width: 140.w,
                        height: 30.h,
                        textstyle: TextStyles.font11WhiteW500.copyWith(fontSize: 15.sp),
                        title: "Update Info",
                        onTap: () {
                          if (_nameController.text.trim().isNotEmpty &&
                              _phoneController.text.trim().isNotEmpty) {
                            
                            _editProfileCubit.updateProfile(
                              name: _nameController.text.trim(),
                              phone: _phoneController.text.trim(),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("please fill in all required fields")),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}