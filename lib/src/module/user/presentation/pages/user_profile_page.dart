import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/core.dart';
import '../../user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.userId,
    super.key,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => sl<ProfileBloc>()..add(GetUserInfoEvent(userId)),
        ),
        BlocProvider<ImagePickerCubit>(
          create: (context) => sl<ImagePickerCubit>(),
        ),
      ],
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is UpdatedUserPhotoState) {
            context.read<ProfileBloc>().add(GetUserInfoEvent(userId));
          }

          if (state is UpdatedUserNameState) {
            context.read<ProfileBloc>().add(GetUserInfoEvent(userId));
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is LoadingProfileState) {
              return const LoadingWidget();
            } else if (state is LoadedUserProfileState) {
              return NestedProfilePage(
                user: state.user,
              );
            } else if (state is ProfileFailureState) {
              return MyErrorWidget(
                message: state.message.toString(),
              );
            }
            return const Text('Some Error');
          },
        ),
      ),
    );
  }
}

class NestedProfilePage extends StatelessWidget {
  const NestedProfilePage({super.key, required this.user});

  final UserEntity user;

  static GlobalKey<FormState> userNameFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: user.name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: REdgeInsets.all(35.0),
        child: Column(
          children: [
            BlocBuilder<ImagePickerCubit, ImagePickerState>(
              builder: (context, state) {
                return Column(
                  children: [
                    CircleProfileWidget(
                      imageUrl: state.userPhototUrl.isEmpty
                          ? user.photoURL!
                          : state.userPhototUrl,
                      isUpdate: state.userPhototUrl.isEmpty,
                      isFileImage: state.userPhototUrl.isNotEmpty,
                      onTap: () async {
                        AppBottomSheet.showBottomSheet(
                          context: context,
                          title: '',
                          content: updateUserPhotoBottomSheetContent(
                            context: context,
                            user: user,
                          ),
                        );
                      },
                    ),
                    state.userPhototUrl.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                sizedBoxHeight: 30.w,
                                sizedBoxWidth: 100.w,
                                isOutlinedButton: true,
                                onPressed: () {
                                  BlocProvider.of<ImagePickerCubit>(context)
                                      .initialImage();
                                },
                                text: 'Cencel',
                              ),
                              15.horizontalSpace,
                              CustomButton(
                                sizedBoxHeight: 30.w,
                                sizedBoxWidth: 100.w,
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(UpdateUserPhotoEvent(
                                    userId: user.userID!,
                                    userPhotoUrl: state.userPhototUrl,
                                  ));
                                  BlocProvider.of<ImagePickerCubit>(context)
                                      .initialImage();
                                },
                                text: 'Save',
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
            50.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidUser,
                      size: 20,
                    ),
                    20.horizontalSpace,
                    user.name!.isNotEmpty
                        ? Text(
                            user.name!,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          )
                        : Text(
                            'Not specified',
                            style: TextStyle(
                                color: Colors.white38, fontSize: 14.sp),
                          ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    AppBottomSheet.showBottomSheet(
                      context: context,
                      title: 'Update name',
                      content: UpdateNameContent(
                        user: user,
                        userNameFormKey: userNameFormKey,
                        nameController: nameController,
                        onTap: () {
                          if (userNameFormKey.currentState!.validate()) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(UpdateUserNameEvent(
                              userId: user.userID!,
                              userName: nameController.text,
                            ));
                            nameController.clear();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    );
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.pen,
                    size: 15,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            user.phoneNumber!.isNotEmpty
                ? Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.phone,
                        size: 20,
                      ),
                      20.horizontalSpace,
                      user.phoneNumber!.isNotEmpty
                          ? Text(
                              user.phoneNumber!,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            )
                          : Text(
                              'Not specified',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 14.sp),
                            ),
                    ],
                  )
                : Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidEnvelope,
                        size: 20,
                      ),
                      20.horizontalSpace,
                      user.email!.isNotEmpty
                          ? Text(
                              user.email!,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            )
                          : Text(
                              'Not specified',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 14.sp),
                            ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  updateUserPhotoBottomSheetContent({
    required BuildContext context,
    required UserEntity user,
  }) {
    return Padding(
      padding: REdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  BlocProvider.of<ImagePickerCubit>(context)
                      .getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.folder,
                  size: 70,
                  color: Colors.orange,
                ),
              ),
              const Text(
                'Gallery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          40.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  BlocProvider.of<ImagePickerCubit>(context)
                      .getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 70,
                  color: Colors.orange,
                ),
              ),
              const Text(
                'Camera',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget updateNameBottomSheetContent({
    required BuildContext context,
    required UserEntity user,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
  }) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: nameController,
            sizedBoxHeight: 64.h,
            labelText: 'Name',
          ),
          20.verticalSpace,
          CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<ProfileBloc>().add(UpdateUserNameEvent(
                      userId: user.userID!,
                      userName: nameController.text,
                    ));
                nameController.clear();
                Navigator.pop(context);
              }
            },
            text: 'SAVE NAME',
          ),
          25.verticalSpace,
        ],
      ),
    );
  }
}
