import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app_constants/colors/app_colors.dart';

class CircleProfileWidget extends StatelessWidget {
  const CircleProfileWidget({
    required this.onTap,
    required this.imageUrl,
    this.isUpdate = false,
    this.isFileImage = false,
    super.key,
  });

  final VoidCallback onTap;
  final String imageUrl;
  final bool? isUpdate;
  final bool? isFileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: imageUrl.isNotEmpty
                  ? Border.all(style: BorderStyle.none)
                  : Border.all(color: AppColors.blue),
            ),
            child: imageUrl.isNotEmpty
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: isFileImage!
                        ? FileImage(File(imageUrl))
                        : NetworkImage(imageUrl),
                  )
                : Padding(
                    padding: REdgeInsets.all(35.0),
                    child: const FaIcon(
                      FontAwesomeIcons.user,
                      size: 30,
                      color: AppColors.blue,
                    ),
                  ),
          ),
        ),
        isUpdate!
            ? Positioned(
                bottom: 11,
                right: 11,
                child: InkWell(
                  onTap: onTap,
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 30,
                    color: imageUrl.isNotEmpty ? Colors.blue : AppColors.blue,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
