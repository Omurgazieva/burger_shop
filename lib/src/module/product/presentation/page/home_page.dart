import 'package:burger_shop/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>()..add(GetAllProductsEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is LoadingProductsState) {
            return const LoadingWidget();
          } else if (state is LoadedProductsState) {
            return NestedHomePage(
              user: user,
              burgersList: state.allProducts
                  .where((i) => i.category == 'Burger')
                  .toList(),
              saladsList: state.allProducts
                  .where((i) => i.category == 'Salad')
                  .toList(),
              drinksList: state.allProducts
                  .where((i) => i.category == 'Drink')
                  .toList(),
            );
          } else if (state is ProductFailureState) {
            return MyErrorWidget(message: state.message.toString());
          }
          return const Text('Some Error');
        },
      ),
    );
  }
}

final _items = ['Burgers', 'Salads', 'Drinks'];

class NestedHomePage extends StatelessWidget {
  const NestedHomePage({
    super.key,
    required this.user,
    required this.burgersList,
    required this.saladsList,
    required this.drinksList,
  });

  final UserEntity user;
  final List<ProductEntity> burgersList;
  final List<ProductEntity> saladsList;
  final List<ProductEntity> drinksList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white, size: 30),
      actions: [
        MenuAnchorWidget(
          user: user,
          onTap: () {
            context.read<AuthBloc>().add(SignOutEvent());
          },
        ),
        10.horizontalSpace,
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrdersPage(),
              ),
            );
          },
          child: Padding(
            padding: REdgeInsets.only(right: 25.0),
            child: const FaIcon(
              FontAwesomeIcons.layerGroup,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The most juicy',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'and delicious burgers',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          10.verticalSpace,
          TabBar(
            padding: REdgeInsets.symmetric(vertical: 21),
            dividerHeight: 0,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 14.sp),
            unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            unselectedLabelColor: Colors.white,
            tabs: _items.map((e) => Tab(text: e, height: 35)).toList(),
          ),
          15.verticalSpace,
          Expanded(
            child: TabBarView(
              children: [
                ProductListView(productList: burgersList),
                ProductListView(productList: saladsList),
                ProductListView(productList: drinksList),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShippingAddressPage(
                        user: user,
                      ),
                    ),
                  );
                },
                child: const FaIcon(FontAwesomeIcons.locationDot,
                    color: Colors.white),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(
                        userId: user.userID!,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.orange,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodsPage(
                        user: user,
                      ),
                    ),
                  );
                },
                child:
                    const FaIcon(FontAwesomeIcons.wallet, color: Colors.white),
              ),
            ],
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
