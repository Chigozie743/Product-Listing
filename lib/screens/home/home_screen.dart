import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/constants/widgets/appbar_icons.dart';
import 'package:product_listing_app/constants/widgets/feeds_grid.dart';
import 'package:product_listing_app/constants/widgets/nav_constants.dart';
import 'package:product_listing_app/constants/widgets/sale_widget.dart';
import 'package:product_listing_app/constants/widgets/text.dart';
import 'package:product_listing_app/core/api_services.dart';
import 'package:product_listing_app/models/products_model.dart';
import 'package:product_listing_app/models/users_model.dart';
import 'package:product_listing_app/screens/authentication/login_screen/login_screen.dart';
import 'package:product_listing_app/screens/category/categories_screen.dart';
import 'package:product_listing_app/screens/drawer/drawer_screen.dart';
import 'package:product_listing_app/screens/feeds/feeds_screen.dart';
import 'package:product_listing_app/screens/users/users_screen.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  //List<ProductsModel> productList = [];

  UsersModel? user;
  bool isError = false;
  String errorStr = "";


  Future<void> usersInfo() async{
    try {
      user = await APIServices.singleUser();
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      //log("error $error");
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      usersInfo();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final usersModelProvider = Provider.of<UsersModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
        child: Scaffold(
          
          ////////////////////////////////////////////////////////////////////
          /// PHASE 1: APP BAR SECTION
          ///////////////////////////////////////////////////////////////////
          appBar: AppBar(
            //elevation: 4,
            title: const Text(
              "Home",
            ),
            actions: [
              AppBarIcons(
                function: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const UsersScreen(),
                    ),
                  );
                },
                icon: IconlyBold.user3,
              ),
            ],
          ),

          ////////////////////////////////////////////////////////////////////
          /// DRAWER MENU SECTION
          ///////////////////////////////////////////////////////////////////
          drawer: Drawer(
            child: ListView(
              children: [
                if (user != null)
                UserAccountsDrawerHeader(
                  accountName: ProductListText(
                    text: user!.name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    textColor: blackText,
                  ),
                  accountEmail: ProductListText(
                    text: user!.email,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    textColor: blackText,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        user!.avatar!),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://appmaking.co/wp-content/uploads/2021/08/android-drawer-bg.jpeg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  
                ),
                ListTile(
                  leading: Icon(IconlyBold.home, color: pinkText,),
                  title: ProductListText(
                    text: "Home",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    textColor: blackText,
                  ),
                  onTap: () {
                    nextScreen(context, const HomeScreen());
                  },
                ),
                ListTile(
                  leading: Icon(IconlyBold.profile, color: pinkText,),
                  title: ProductListText(
                    text: "About",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    textColor: blackText,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.grid_3x3_outlined, color: pinkText,),
                  title: ProductListText(
                    text: "Products Feeds",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    textColor: blackText,
                  ),
                  onTap: () {
                    nextScreen(context, const FeedsScreen());
                  },
                ),
                ListTile(
                  leading: Icon(IconlyBold.category, color: pinkText,),
                  title: ProductListText(
                    text: "Categories",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    textColor: blackText,
                  ),
                  onTap: () {
                    nextScreen(context, const CategoriesScreen());
                  },
                ),
                ListTile(
                  leading: Icon(IconlyBold.logout, color: pinkText,),
                  title: ProductListText(
                    text: "Log Out",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    textColor: pinkText,
                  ),
                  onTap: () {
                    nextScreen(context, const LoginScreen());
                  },
                )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              children: [
                SizedBox( height: 18.sp,),

                ////////////////////////////////////////////////////////////////////
                /// PHASE 2: SEARCH BAR SECTION
                ///////////////////////////////////////////////////////////////////
                TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Theme.of(context).cardColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 1.1.sp,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: lightIconsColor,
                    ),
                  ),
                ),
                SizedBox(height: 18.sp,),

                ////////////////////////////////////////////////////////////////////
                /// PHASE 3: PRODUCT SWIPER SECTION
                ///////////////////////////////////////////////////////////////////
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height.sp * 0.19.sp,
                          child: Swiper(
                            itemCount: 3,
                            itemBuilder: (ctx, index){
                              return const SaleWidget();
                            },
                            autoplay: true,
                            pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.redAccent[700],
                              ),
                            ),
                          ),
                        ),
                        
                        ////////////////////////////////////////////////////////////////////
                        /// PHASE 4: LATEST PRODUCT SECTION
                        ///////////////////////////////////////////////////////////////////
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                "Latest Products",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0
                                ),
                              ),

                              const Spacer(),

                              ///******** Navigate to Feeds Screen *****/
                              AppBarIcons(
                                  function: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const FeedsScreen(),
                                      ),
                                    );
                                  },
                                  icon: IconlyBold.arrowRight2,
                              ),
                            ],
                          ),
                        ),


                        //*****************************************************************/
                        //  PRODUCT LISTING
                        //*****************************************************************/
                        FutureBuilder<List<ProductsModel>>(
                          future: APIServices.getALlProducts(limit: "3"),
                          builder: ((context, snapshot){
                            if(snapshot.connectionState ==
                            ConnectionState.waiting){
                              return Center(
                                child: HeartbeatProgressIndicator(
                                  child:  const Icon(Icons.home, color: Colors.pink,),
                                ),
                              );
                            } else if(snapshot.hasError){
                              Center(
                                child: Text("An error occured ${snapshot.error}"),
                              );
                            } else if(snapshot.data == null){
                              const Center(
                                child: Text("No product has been added yet"),
                              );
                            }
                            return FeedsGridWidget(productsList: snapshot.data!);
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
