import 'dart:developer';
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/core/api_services.dart';
import 'package:product_listing_app/models/products_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  ProductsModel? productsModel;
  bool isError = false;
  String errorStr = "";

  Future<void> getProductInfo() async{
    //productsModel = await APIServices.getProductsById(id: widget.id);
    try {
      productsModel = await APIServices.getProductsById(id: widget.id);
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      //log("error $error");
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: isError
              ? Center(
                child: Text(
                "An error occured $errorStr",
                  style: TextStyle(
                      fontSize: 25.sp, fontWeight: FontWeight.w500),
                ),
            )
            : productsModel == null
            ? Center(child: GlowingProgressIndicator(
          child: Icon(Icons.shopping_bag, color: Colors.pink, size: 50.sp,),
        ),)
            :SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 18.sp,),
              const BackButton(),
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //////////////////////////////////////////////////////
                    /// PHASE 1: PRODUCT CATEGORY, NAME AND AMOUNT
                    //////////////////////////////////////////////////////
                    Text(
                      productsModel!.category!.name.toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 18.sp,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            productsModel!.title.toString(),
                            style: titleStyle,
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          child: RichText(
                            text: TextSpan(
                              text: '\$',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: const Color.fromRGBO(33, 150, 243, 1),
                              ),
                              children: <TextSpan>[
                                TextSpan( text: productsModel!.price.toString(),
                                  style: TextStyle(
                                    color: lightTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18.0,),
                  ],
                ),
              ),

              ///////////////////////////////////////////////////////////////////////
              /// PHASE 2: PRODUCT IMAGE SWIPER
              ///////////////////////////////////////////////////////////////////////
              SizedBox(
                height: size.height * 0.4,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return FancyShimmerImage(
                      width: double.infinity,
                      imageUrl: productsModel!.images![index][0],
                      boxFit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: min(3, productsModel!.images!.length),
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.green,
                      activeColor: Colors.redAccent[700],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 18.sp,),

              ////////////////////////////////////////////////////////////////////
              /// PHASE 3: PRODUCT DESCRIPTION
              ///////////////////////////////////////////////////////////////////
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",
                      style: titleStyle,
                    ),

                    const SizedBox(height: 18.0,),

                    Text( productsModel!.description.toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 25.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
