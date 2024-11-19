import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../logic/logic.dart';

class ShippingAddressCardWidget extends StatefulWidget {
  const ShippingAddressCardWidget({
    super.key,
    required this.address,
    required this.user,
  });

  final ShippingAddressEntity address;
  final UserEntity user;

  @override
  State<ShippingAddressCardWidget> createState() =>
      _ShippingAddressCardWidgetState();
}

class _ShippingAddressCardWidgetState extends State<ShippingAddressCardWidget> {
  final GlobalKey<FormState> _shippingAddressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.address.userName);
    TextEditingController addressController =
        TextEditingController(text: widget.address.address);
    TextEditingController cityController =
        TextEditingController(text: widget.address.city);
    TextEditingController countryController =
        TextEditingController(text: widget.address.country);
    return Card(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 25, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.address.userName!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                    onTap: () {
                      AppBottomSheet.showBottomSheet(
                        context: context,
                        title: 'Update Shipping Address',
                        content: shippingAddressBottomSheetContent(
                          isUpdate: true,
                          shippingAddressId: widget.address.id,
                          context: context,
                          userId: widget.user.userID!,
                          formKey: _shippingAddressFormKey,
                          nameController: nameController,
                          addressController: addressController,
                          cityController: cityController,
                          countryController: countryController,
                        ),
                      );
                    },
                    child: Text('Edit', style: AppTextStyles.red12)),
              ],
            ),
            12.verticalSpace,
            Text(
              widget.address.address!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
            5.verticalSpace,
            Text(
              '${widget.address.city},  ${widget.address.country}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
            14.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: widget.address.isCheked,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    if (widget.address.isCheked == false) {
                      BlocProvider.of<ShippingAddressCubit>(context)
                          .selectDefaultShippingAddress(
                        userId: widget.address.userId!,
                        addressId: widget.address.id!,
                      );
                    }
                  },
                ),
                Text(
                  'Use as the shipping address',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget shippingAddressBottomSheetContent({
  required bool isUpdate,
  required BuildContext context,
  required String userId,
  required GlobalKey<FormState> formKey,
  required TextEditingController nameController,
  required TextEditingController addressController,
  required TextEditingController cityController,
  required TextEditingController countryController,
  String? shippingAddressId,
}) {
  bool isChecked = true;

  return Form(
    key: formKey,
    child: Column(
      children: [
        CustomTextFormField(
          controller: nameController,
          sizedBoxHeight: 64.h,
          labelText: 'Full name',
          validator: (String? value) =>
              value!.isEmpty ? Strings.fieldReq : null,
        ),
        10.verticalSpace,
        CustomTextFormField(
          controller: addressController,
          sizedBoxHeight: 64.h,
          labelText: 'Address',
          validator: (String? value) =>
              value!.isEmpty ? Strings.fieldReq : null,
        ),
        10.verticalSpace,
        CustomTextFormField(
          controller: cityController,
          sizedBoxHeight: 64.h,
          sizedBoxWidth: double.infinity,
          labelText: 'City',
          validator: (String? value) =>
              value!.isEmpty ? Strings.fieldReq : null,
        ),
        10.verticalSpace,
        CustomTextFormField(
          controller: countryController,
          sizedBoxHeight: 64.h,
          labelText: 'Country',
          validator: (String? value) =>
              value!.isEmpty ? Strings.fieldReq : null,
        ),
        10.verticalSpace,
        CustomCheckBox(
          isCheckedCallback: (value) => isChecked = value,
          isTitle: true,
          title: 'Set as default shipping address',
        ),
        20.verticalSpace,
        CustomButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              isUpdate
                  ? BlocProvider.of<ShippingAddressCubit>(context)
                      .updateShippingAddress(
                      newAddress: ShippingAddressEntity(
                        id: shippingAddressId,
                        userId: userId,
                        userName: nameController.text,
                        address: addressController.text,
                        city: cityController.text,
                        country: countryController.text,
                        isCheked: isChecked,
                      ),
                    )
                  : BlocProvider.of<ShippingAddressCubit>(context)
                      .addShippingAddress(
                      address: ShippingAddressEntity(
                        userId: userId,
                        userName: nameController.text,
                        address: addressController.text,
                        city: cityController.text,
                        country: countryController.text,
                        isCheked: isChecked,
                      ),
                    );
              nameController.clear();
              addressController.clear();
              cityController.clear();
              Navigator.pop(context);
            }
          },
          text: 'SAVE ADDRESS',
        ),
        25.verticalSpace,
      ],
    ),
  );
}
