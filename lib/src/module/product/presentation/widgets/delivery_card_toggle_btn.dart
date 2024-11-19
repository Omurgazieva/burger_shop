import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../../user/user.dart';

class DeliveryCardToggleButton extends StatefulWidget {
  const DeliveryCardToggleButton({
    required this.selectedItemsCallback,
    super.key,
  });
  final ValueSetter<DeliveryEntity> selectedItemsCallback;

  @override
  State<DeliveryCardToggleButton> createState() =>
      _DeliveryCardToggleButtonState();
}

class _DeliveryCardToggleButtonState extends State<DeliveryCardToggleButton> {
  final List<bool> isSelectedList = [true, false, false];
  String selectedItemName = '';

  List<DeliveryEntity> deliveryList = [
    DeliveryEntity(
      id: '0',
      name: 'FedEx',
      days: 3,
      price: 15,
      image: AppAssets.fedex(width: 60.h, height: 37.h),
    ),
    DeliveryEntity(
      id: '1',
      name: 'USPSCOM',
      days: 3,
      price: 20,
      image: AppAssets.usps(width: 60.h, height: 37.h),
    ),
    DeliveryEntity(
      id: '2',
      name: 'DHL',
      days: 3,
      price: 30,
      image: AppAssets.dhl(width: 60.h, height: 37.h),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        singleToggleButton(0, deliveryList[0]),
        singleToggleButton(1, deliveryList[1]),
        singleToggleButton(2, deliveryList[2]),
      ],
    );
  }

  Widget singleToggleButton(int itemIndex, DeliveryEntity item) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          for (int index = 0; index < isSelectedList.length; index++) {
            if (index == itemIndex) {
              setState(() {
                isSelectedList[index] = true;
                selectedItemName = item.name!;
                widget.selectedItemsCallback(item);
              });
            } else {
              setState(() => isSelectedList[index] = false);
              widget.selectedItemsCallback(item);
            }
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: isSelectedList[itemIndex]
                ? const BorderSide(color: Colors.white38, width: 2.0)
                : BorderSide.none,
          ),
          child: SizedBox(
            height: 72.h,
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.image!,
                //3.verticalSpace,
                Text(
                  '2-${item.days!} days',
                  style: AppTextStyles.grey11,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
