import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../user.dart';

class ShippingAddressPage extends StatelessWidget {
  const ShippingAddressPage({
    required this.user,
    super.key,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ShippingAddressCubit>(),
      child: BlocListener<ShippingAddressCubit, ShippingAddressState>(
        listener: (context, state) {
          if (state is AddedShippingAddresState) {
            BlocProvider.of<ShippingAddressCubit>(context).getShippingAddress(
              userId: user.userID!,
            );
          }

          if (state is UpdatedShippingAddresState) {
            BlocProvider.of<ShippingAddressCubit>(context).getShippingAddress(
              userId: user.userID!,
            );
          }
        },
        child: BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
          builder: (context, state) {
            if (state is LoadingShippingAddresState) {
              return const LoadingWidget();
            } else if (state is InitialShippingAddresState) {
              return NestedShippingAddressView(
                addressList:
                    user.shippingAddresses as List<ShippingAddressEntity>,
                user: user,
              );
            } else if (state is LoadedShippingAddressState) {
              return NestedShippingAddressView(
                addressList: state.addressList,
                user: user,
              );
            } else if (state is ShippingAddresFailureState) {
              return MyErrorWidget(message: state.message.toString());
            }
            return const Text('Some error');
          },
        ),
      ),
    );
  }
}

class NestedShippingAddressView extends StatelessWidget {
  final List<ShippingAddressEntity> addressList;
  final UserEntity user;

  NestedShippingAddressView({
    super.key,
    required this.addressList,
    required this.user,
  });

  final GlobalKey<FormState> _shippingAddressFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController(text: 'Kyrgyzstan');

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Shipping Address',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        body: addressList.isNotEmpty
            ? buildBodyShippngAddress()
            : Align(
                alignment: Alignment.center,
                child: Text(
                  'Add your shipping address!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.h,
                  ),
                ),
              ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 80,
          child: Padding(
            padding: REdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  sizedBoxHeight: 36.w,
                  sizedBoxWidth: 160.w,
                  isOutlinedButton: true,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  textStyle: TextStyle(color: Colors.white, fontSize: 10.sp),
                  text: 'BACK',
                ),
                CustomButton(
                  sizedBoxHeight: 36.w,
                  sizedBoxWidth: 160.w,
                  onPressed: () {
                    AppBottomSheet.showBottomSheet(
                      context: context,
                      title: 'Adding Shipping Address',
                      content: shippingAddressBottomSheetContent(
                        isUpdate: false,
                        context: context,
                        userId: user.userID!,
                        formKey: _shippingAddressFormKey,
                        nameController: nameController,
                        addressController: addressController,
                        cityController: cityController,
                        countryController: countryController,
                      ),
                    );
                  },
                  textStyle: TextStyle(color: Colors.white, fontSize: 10.sp),
                  text: 'ADD NEW ADDRESS',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBodyShippngAddress() {
    return Padding(
      padding: REdgeInsets.all(16),
      child: ListView.builder(
        itemCount: addressList.length,
        itemBuilder: (context, index) {
          final address = addressList[index];
          return BlocProvider.value(
            value: BlocProvider.of<ShippingAddressCubit>(context),
            child: ShippingAddressCardWidget(
              address: address,
              user: user,
            ),
          );
        },
      ),
    );
  }
}
