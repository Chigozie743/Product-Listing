import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_listing_app/constants/app_assets.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/constants/widgets/app_snackbar.dart';
import 'package:product_listing_app/constants/widgets/button_widget.dart';
import 'package:product_listing_app/constants/widgets/nav_constants.dart';
import 'package:product_listing_app/constants/widgets/text.dart';
import 'package:product_listing_app/constants/widgets/text_field_box.dart';
import 'package:product_listing_app/core/api_services.dart';
import 'package:product_listing_app/models/create_users_model.dart';
import 'package:product_listing_app/models/response_model.dart';
import 'package:product_listing_app/models/secure_storage.dart';
import 'package:product_listing_app/screens/authentication/register_screen/register_screen.dart';
import 'package:product_listing_app/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isButtonEnabled = false;
  bool isPasswordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add listeners to the text controllers
    emailController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
  }

  /////////////////////////////////////////////////////////////////////////
  /// Update the button state based on the text controllers
  /// This will trigger a rebuild of the button widget
  /////////////////////////////////////////////////////////////////////////
  void updateButtonState() {
    // Update the state to trigger a rebuild
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty && 
        passwordController.text.isNotEmpty;
    });
  }

  /////////////////////////////////////////////////////////////////////////
  /// Function to trigger the login
  /////////////////////////////////////////////////////////////////////////
  void login() async{
    try {
      // Create a CreateUserModel object with the data from text controllers
      CreateUserModel payload = CreateUserModel(
        email: emailController.text,
        password: passwordController.text,    // You may need to provide a default avatar or allow the user to set one
      );

      // Call the registerUser method from APIServices
      ResponseModel user = await APIServices.loginUser(payload: payload);

      // Registration successful, you can handle the user object as needed
      print("User registered successfully: ${user.accessToken}");
      
      // You may want to navigate to the home screen or perform other actions here
      if(context.mounted){
        AppSnackbar showToast = AppSnackbar(context);
            showToast.showToast(text: "Login Successful");
            SecureStorage().userDataSave(user);
        nextScreen(context, const HomeScreen());
      }
      
    } catch (error) {
      // Handle errors - display an error message, log the error, etc.
      print("Error during registration: $error");

      // You may want to show an error message to the user
      if(context.mounted){
        AppSnackbar errorToast = AppSnackbar(context, isError: true);
        errorToast.showToast(text: "Login Failed");
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 15.sp, right: 15.sp, bottom: 15.sp, top: 60.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ////////////////////////////////////////////////////////////////
                  /// PHASE 1: CLOSE ICON
                  ///////////////////////////////////////////////////////////////
                  Row(
                    children: [
                      GestureDetector(
                        // onTap: () {
                        //   Navigator.pop(context);
                        // },
                        child: Image.asset(
                          ProductAssetsPaths.closeIcon,
                          color: pinkText,
                          height: 24.sp,
                          width: 24.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                
                  ////////////////////////////////////////////////////////////////
                  /// PHASE 2: TEXT
                  ///////////////////////////////////////////////////////////////
                  ProductListText(
                    text: "Login",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    textColor: pinkText,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                
                  SizedBox(
                    width: 207.sp,
                    child: ProductListText(
                      text: "Securely login to your Product Listing account.",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      textColor: greyText,
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                
                  ////////////////////////////////////////////////////////////////
                  /// PHASE 3: TEXT FIELDS
                  ///////////////////////////////////////////////////////////////
                  SizedBox(
                    child: TextFieldBox(
                      controller: emailController,
                      headText: "Email ",
                      hintText: "Enter your Email",
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
          
                  SizedBox(
                    child: TextFieldBox(
                      controller: passwordController,
                      headText: "Password",
                      hintText: "Password",
                      obscureText: !isPasswordVisible,
                      suffixIcon: Icon(
                        isPasswordVisible ?
                        Icons.visibility_off :
                        Icons.visibility,
                        color: greyTextField,
                      ),
                      onIconPressed: (){
                        setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.sp,
                  ),
                
                  ////////////////////////////////////////////////////////////////
                  /// PHASE 4: BUTTONS
                  ///////////////////////////////////////////////////////////////
                  Button(
                    onClick: (){
                      login();
                    },
                    backgroundColor: isButtonEnabled ? pinkText : disabledButton,
                    textColor: isButtonEnabled ?  whiteText : blackText,
                    width: size.width.sp,
                    fontSize: 20.sp,
                    text: "Login",
                    height: 56.sp,
                    radius: 10.r,
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                
                  ////////////////////////////////////////////////////////////////
                  /// PHASE 5: Other Options Text
                  ///////////////////////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductListText(
                        text: "Don’t have an account?",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textColor: greyText,
                      ),
                      SizedBox(
                        width: 2.sp,
                      ),
          
                      GestureDetector(
                        onTap: () {
                          nextScreen(context, const RegisterScreen());
                        },
                        child: ProductListText(
                          text: "Register",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textColor: pinkText,
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}