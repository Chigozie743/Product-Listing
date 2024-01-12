import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/constants/navigator.dart';
import 'package:product_listing_app/models/response_model.dart';
import 'package:product_listing_app/models/secure_storage.dart';
import 'package:product_listing_app/screens/authentication/login_screen/login_screen.dart';
import 'package:product_listing_app/screens/home/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // if(kIsWeb){
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyD1OLLJ-FwUCAB9vmCf1qKLIN504r0l8Rk",
  //       appId: "1:140218687365:web:b1d01da6e22c7439be2eec",
  //       messagingSenderId: "140218687365",
  //       projectId: "product-listing-app-fa872",
  //     )
  //   );
  // }

  //await Firebase.initializeApp();
  ResponseModel? user  = await SecureStorage().userDataRead();
  bool authenticated = user != null ? true : false;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
      
  runApp(MyApp(authenticated: authenticated,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authenticated});

  final bool authenticated;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Product App',
            theme: ThemeData(
              //canvasColor: Colors.transparent,
              datePickerTheme: const DatePickerThemeData(
                headerBackgroundColor: Colors.green,
              ),
              scaffoldBackgroundColor: lightScaffoldColor,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: lightIconsColor,
                ),
                centerTitle: true,
                titleTextStyle: TextStyle(
                  color: lightTextColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0.0,
              ),
              iconTheme: IconThemeData(
                color: lightIconsColor,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.black,
                selectionColor: Colors.blue,
                //selectionHandleColor: Colors.blue,
              ),
              cardColor: lightCardColor,
              brightness: Brightness.light,
              colorScheme: ThemeData().colorScheme.copyWith(
                    secondary: lightIconsColor,
                    brightness: Brightness.light,
                  ),
            ),
            home: authenticated ? const HomeScreen() : const LoginScreen(),
          );
        });
  }
}