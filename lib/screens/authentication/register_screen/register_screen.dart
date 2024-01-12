import 'package:flutter/gestures.dart';
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
import 'package:product_listing_app/models/secure_storage.dart';
import 'package:product_listing_app/models/users_model.dart';
import 'package:product_listing_app/screens/authentication/login_screen/login_screen.dart';
import 'package:product_listing_app/screens/authentication/re_login/re_login_screen.dart';
import 'package:product_listing_app/screens/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool? checked = false;
  bool isButtonEnabled = false;
  bool isPasswordVisible = false;
  String fontFamily = 'U8Regular';

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add listeners to the text controllers
    emailController.addListener(updateButtonState);
    fullNameController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
    userNameController.addListener(updateButtonState);
  }

  /////////////////////////////////////////////////////////////////////////
  /// Update the button state based on the text controllers
  /// This will trigger a rebuild of the button widget
  /////////////////////////////////////////////////////////////////////////
  void updateButtonState() {
    // Update the state to trigger a rebuild
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        userNameController.text.isNotEmpty;
    });
  }

  /////////////////////////////////////////////////////////////////////////
  /// Function to trigger the registration
  /////////////////////////////////////////////////////////////////////////
  void registerAccount() async{
    // Validate if the input contains only alphabets and numbers
  if (!isValidInput(fullNameController.text) ||
      !isValidInput(userNameController.text) ||
      !isValidInput(passwordController.text)) {
    if (context.mounted) {
      AppSnackbar errorToast = AppSnackbar(context, isError: true);
      errorToast.showToast(text: "Only alphabets and numbers are allowed");
    }
    return; // Do not proceed with registration if the input is invalid
  }

    try {
      // Create a CreateUserModel object with the data from text controllers
      CreateUserModel payload = CreateUserModel(
        email: emailController.text,
        password: passwordController.text,
        name: fullNameController.text,
        role: "admin", // Assuming a default role for simplicity, you can modify this
        avatar: "https://picsum.photos/800",    // You may need to provide a default avatar or allow the user to set one
      );

      // Call the registerUser method from APIServices
      UsersModel user = await APIServices.registerUser(payload: payload);

      // Registration successful, you can handle the user object as needed
      print("User registered successfully: ${user.name}");
      if(context.mounted){
        AppSnackbar showToast = AppSnackbar(context);
            showToast.showToast(text: "Regitration Successful");
            //SecureStorage().userDataSave(user);
        nextScreen(context, const ReLoginScreen());
      }
      // You may want to navigate to the home screen or perform other actions here
    } catch (error) {
      // Handle errors - display an error message, log the error, etc.
      print("Error during registration: $error");
      // You may want to show an error message to the user
      if(context.mounted){
        AppSnackbar errorToast = AppSnackbar(context, isError: true);
        errorToast.showToast(text: "Registration Failed");
      }
    }
  }


  // Function to check if input contains only alphabets and numbers
  bool isValidInput(String input) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    return regex.hasMatch(input);
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
                        onTap: () {
                          Navigator.pop(context);
                        },
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
                    text: "Register Account",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    textColor: pinkText,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                
                  SizedBox(
                    width: 308.sp,
                    child: ProductListText(
                      text: "Register to buy your digital assets seamlessly from product list.",
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
                      controller: fullNameController,
                      headText: "Full name",
                      hintText: "Full name",
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),

                  SizedBox(
                    child: TextFieldBox(
                      controller: userNameController,
                      headText: "Username",
                      hintText: "Username",
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),

                  SizedBox(
                    child: TextFieldBox(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      headText: "Email Address",
                      hintText: "Email Address",
                    ),
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
                    height: 15.sp,
                  ),

                  /////////////////////////////////////////////////////////////////////////////
                  /// 
                  ////////////////////////////////////////////////////////////////////////////
                  Row(
                    children: [
                      Checkbox(
                        activeColor: pinkText,
                        side: BorderSide(
                          color: greyText,
                          width: 2.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        value: checked,
                        onChanged: (bool? value) {
                          setState(() {
                            checked = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 270.sp,
                        child: Text.rich(
                          TextSpan(
                            text: "I certify that I’m 18 years of age or older, and I agree to the ",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w400,
                              color: mainBlack,
                              letterSpacing: 0.2.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "User Agreement",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w400,
                                    color: greenBackground,
                                    letterSpacing: 0.2.sp,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //nextScreen(context, const LaunchTerms());
                                    }),
                              TextSpan(
                                text: " and",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  color: blackText,
                                  letterSpacing: 0.2.sp,
                                ),
                              ),
                              TextSpan(
                                text: " Privacy Policy.",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w400,
                                  color: greenBackground,
                                  letterSpacing: 0.2.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //nextScreen(context, const LaunchPolicy());
                                  }
                                ),
                              
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30.sp,
                  ),
                
                  ////////////////////////////////////////////////////////////////
                  /// PHASE 4: BUTTONS
                  ///////////////////////////////////////////////////////////////
                  Button(
                    onClick: (){
                      registerAccount();
                      //nextScreen(context, const HomeScreen());
                    },
                    backgroundColor: isButtonEnabled ? pinkText : disabledButton,
                    textColor: isButtonEnabled ?  whiteText : blackText,
                    width: size.width.sp,
                    fontSize: 20.sp,
                    text: "Register",
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
                        text: "Already have an account?",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textColor: greyText,
                      ),
                      SizedBox(
                        width: 2.sp,
                      ),
          
                      GestureDetector(
                        onTap: () {
                          nextScreen(context, const LoginScreen());
                        },
                        child: ProductListText(
                          text: "Sign In",
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