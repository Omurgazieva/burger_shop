import 'package:burger_shop/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewProductPage extends StatelessWidget {
  const AddNewProductPage({super.key});

  static TextEditingController categoryController = TextEditingController();
  static TextEditingController productNameController = TextEditingController();
  static TextEditingController mainTitleController = TextEditingController();
  static TextEditingController subTitleController = TextEditingController();
  static TextEditingController datailTitleController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController mainImgController = TextEditingController();
  static TextEditingController datailImgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add new product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextFormField(
                controller: categoryController,
                labelText: 'Category',
              ),
              5.verticalSpace,
              CustomTextFormField(
                controller: productNameController,
                labelText: 'Product name',
              ),
              5.verticalSpace,
              CustomTextFormField(
                controller: mainTitleController,
                labelText: 'Main title',
              ),
              5.verticalSpace,
              CustomTextFormField(
                controller: subTitleController,
                labelText: 'Subtitle',
              ),
              5.verticalSpace,
              CustomTextFormField(
                controller: datailTitleController,
                labelText: 'Product datail title',
              ),
              5.verticalSpace,
              CustomTextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                labelText: 'Price',
              ),
              5.verticalSpace,
              CustomTextFormField(
                controller: descriptionController,
                sizedBoxHeight: 154.h,
                keyboardType: TextInputType.multiline,
                labelText: 'Enter description',
              ),
              10.verticalSpace,
              CustomTextFormField(
                controller: mainImgController,
                labelText: 'Main image url',
              ),
              5.verticalSpace,
              CustomTextFormField(
                controller: datailImgController,
                labelText: 'Product datail url',
              ),
              10.verticalSpace,
              CustomButton(
                text: 'ADD PRODUCT',
                onPressed: () {
                  context.read<ProductBloc>().add(
                        AddProductEvent(
                          ProductEntity(
                            category: categoryController.text,
                            productName: productNameController.text,
                            mainTitle: mainTitleController.text,
                            subTitle: subTitleController.text,
                            productDatailTitle: datailTitleController.text,
                            price: double.parse(priceController.text),
                            description: descriptionController.text,
                            mainImgUrl: mainImgController.text,
                            datailImgUrl: datailImgController.text,
                          ),
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
