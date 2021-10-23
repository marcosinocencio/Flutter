import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2/models/order_list.dart';
import 'package:shop_2/models/product_list.dart';
import 'package:shop_2/pages/auth_or_home_page.dart';
import 'package:shop_2/pages/cart_page.dart';
import 'package:shop_2/pages/orders_page.dart';
import 'package:shop_2/pages/product_detail_page.dart';
import 'package:shop_2/pages/product_form_page.dart';
import 'package:shop_2/pages/products_page.dart';
import 'package:shop_2/utils/app_routes.dart';
import 'package:shop_2/utils/custom_route.dart';

import 'models/auth.dart';
import 'models/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(fontFamily: 'Lato');
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
            create: (_) => ProductList(),
            update: (context, auth, previous) {
              return ProductList(
                  auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
            }),
        ChangeNotifierProxyProvider<Auth, OrderList>(
            create: (_) => OrderList(),
            update: (ctx, auth, previous) {
              return OrderList(
                  auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
            }),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
            TargetPlatform.android: CustomPageTransitionBuilder(),
          }),
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
        ),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
