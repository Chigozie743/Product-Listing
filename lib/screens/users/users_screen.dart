import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_listing_app/constants/widgets/users_widget.dart';
import 'package:product_listing_app/core/api_services.dart';
import 'package:product_listing_app/models/users_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body:  FutureBuilder<List<UsersModel>>(
        future: APIServices.getALlUsers(),
        builder: ((context, snapshot){
          if(snapshot.connectionState ==
              ConnectionState.waiting){
            return Center(
              //***** Progress Indicator **********/
              child: GlowingProgressIndicator(
                child:  Icon(Icons.groups, color: Colors.pink, size: 50.sp,),
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
          /////////////////////////////////////////////////////////////////////
          /// List of Users Fetched from the API
          ////////////////////////////////////////////////////////////////////
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index){
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const UsersWidget(),
              );
            }
          );
        }),
      ),

    );
  }
}
