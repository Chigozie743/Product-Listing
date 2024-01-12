import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/models/categories_model.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final categoriesModelProvider =
        Provider.of<CategoriesModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: FancyShimmerImage(
              height: size.width * 0.45,
              width: size.width * 0.45,
              errorWidget: const Icon(
                IconlyBold.danger,
                color: Colors.red,
                size: 28.0,
              ),
              imageUrl: categoriesModelProvider.image.toString(),
              boxFit: BoxFit.fill,
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Text(categoriesModelProvider.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                backgroundColor: lightCardColor.withOpacity(0.5)
              ),
            ),
          )
        ],
      ),
    );
  }
}
