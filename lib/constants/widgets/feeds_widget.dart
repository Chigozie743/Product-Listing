import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/models/products_model.dart';
import 'package:product_listing_app/screens/product/products_detail.dart';
import 'package:provider/provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class FeedsWidget extends StatelessWidget {
  const FeedsWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final productsModelProvider = Provider.of<ProductsModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(2.sp),
      child: Material(
        borderRadius: BorderRadius.circular(8.r),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: ProductDetails(id: productsModelProvider.id.toString(),),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: '\$',
                          style: const TextStyle(
                            color: Color.fromRGBO(33, 150, 243, 1)
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${productsModelProvider.price}",
                              style: TextStyle(
                                color: lightTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(IconlyBold.heart),
                  ],
                ),
              ),
          
              SizedBox(height: 10.sp,),
          
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: FancyShimmerImage(
                  height: size.height * 0.2,
                  width: double.infinity,
                  errorWidget: Icon(
                    IconlyBold.danger,
                    color: Colors.red,
                    size: 28.sp,
                  ),
                  imageUrl: productsModelProvider.images![0],
                  boxFit: BoxFit.fill,
                ),
              ),
          
              SizedBox(height: 10.sp,),
          
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: SizedBox(
                  child: Text(
                    productsModelProvider.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.01,)
            ],
          ),
        ),
      ),
    );
  }
}
