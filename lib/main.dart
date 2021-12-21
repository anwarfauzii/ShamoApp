import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/providers/product_providers.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'pages/checkout_success_page.dart';
import 'providers/auth_providers.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_detail_page.dart';
import 'pages/product_page.dart';
import 'pages/detail_chat_page.dart';
import 'pages/edit_profile_page.dart';
import 'pages/home/main_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context)=>WishlistProvider()),


      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => const MainPage(),
          '/detail-chat': (context) => const DetailChatPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutDetailPage(),
          '/checkout-success': (context) => const CheckoutSuccessPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
