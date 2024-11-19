import 'package:burger_shop/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class MenuAnchorWidget extends StatefulWidget {
  const MenuAnchorWidget({
    super.key,
    required this.user,
    required this.onTap,
  });

  final UserEntity user;
  final VoidCallback onTap;

  @override
  State<MenuAnchorWidget> createState() => _MenuAnchorWidgetState();
}

class _MenuAnchorWidgetState extends State<MenuAnchorWidget> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MenuAnchor(
        alignmentOffset: const Offset(-30, 0),
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const FaIcon(
              FontAwesomeIcons.solidUser,
              size: 25,
            ),
            tooltip: 'Show menu',
          );
        },
        menuChildren: [buildProfile()],
      ),
    );
  }

  buildProfile() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: REdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleProfileWidget(
              imageUrl: widget.user.photoURL!,
              isUpdate: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      userId: widget.user.userID!,
                    ),
                  ),
                );
              },
            ),
            10.verticalSpace,
            widget.user.name!.isNotEmpty
                ? Text(
                    widget.user.name!,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  )
                : Text(
                    widget.user.phoneNumber!,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
            20.verticalSpace,
            ListTile(
              contentPadding: EdgeInsets.zero,
              shape: const Border(
                top: BorderSide(color: Colors.white30, width: 0.5),
                bottom: BorderSide(color: Colors.white30, width: 0.5),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      userId: widget.user.userID!,
                    ),
                  ),
                );
              },
              trailing: const Icon(Icons.chevron_right),
              title: Text(
                'Datail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
            //10.verticalSpace,
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: widget.onTap,
              trailing: const Icon(Icons.chevron_right),
              title: Text(
                'Sign out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
