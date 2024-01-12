import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_listing_app/constants/widgets/feeds_widget.dart';
import 'package:product_listing_app/core/api_services.dart';
import 'package:product_listing_app/models/products_model.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductsModel> productList = [];
  int limit = 10;
  //bool _isLoading = false;
  bool _isLimit = false;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async{
    productList = await APIServices.getALlProducts(limit: limit.toString());
    setState(() {

    });
  }

  @override
  void didChangeDependencies() {
    // getProducts();
    _scrollController.addListener(() async {
      if(limit == 30){
        _isLimit = true;
        setState(() {});
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //_isLoading = true;
        limit += 10;
        log("limit $limit");

        await getProducts();
        //_isLoading = true;
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////////////////////////////////////////////////////////////////////
      /// PHASE 1: ALL PRODUCTS APP BAR SECTION
      //////////////////////////////////////////////////////////////////
      appBar: AppBar(
        //elevation: 4,
        title: const Text(
          "All Products",
        ),
      ),
      
      ////////////////////////////////////////////////////////////////////
      /// PHASE 2: ALL PRODUCTS API CALLS
      //////////////////////////////////////////////////////////////////
      body: productList.isEmpty
          ? const Center(child: CircularProgressIndicator(
                color: Colors.pink,
                strokeWidth: 6.0,
              ))
          : SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 0.7,
                          //mainAxisExtent: 500
                  ),
                  itemBuilder: (ctx, index){
                          return ChangeNotifierProvider.value(
                            value: productList[index],
                              child: const FeedsWidget(),
                          );
                  },
                ),
                if (!_isLimit)
                  const Center(child: CircularProgressIndicator(
                    color: Colors.pink,
                    strokeWidth: 6.0,
                  )),
              ],
            ),
          ),
    );
  }
}
