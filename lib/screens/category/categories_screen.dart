import 'package:flutter/material.dart';
import 'package:product_listing_app/constants/widgets/category_widget.dart';
import 'package:product_listing_app/core/api_services.dart';
import 'package:product_listing_app/models/categories_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body:  FutureBuilder<List<CategoriesModel>>(
        future: APIServices.getALlCategories(),
        builder: ((context, snapshot){
          if(snapshot.connectionState ==
              ConnectionState.waiting){
            return Center(
              child: HeartbeatProgressIndicator(
                child:  const Icon(Icons.favorite, color: Colors.pink,),
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
          //////////////////////////////////////////////////////////////////
          ///  RETURNS LIST OF CATEGORIES
          ///////////////////////////////////////////////////////////////////
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (ctx, index){
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                  child: const CategoryWidget(),
              );
            },
          );
        }),
      ),

    );
  }
}
