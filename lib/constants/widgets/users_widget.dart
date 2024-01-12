import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/models/users_model.dart';
import 'package:provider/provider.dart';
class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final usersModelProvider =
    Provider.of<UsersModel>(context);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: FancyShimmerImage(
          height: size.width * 0.15,
          width: size.width * 0.15,
          errorWidget: const Icon(
            IconlyBold.danger,
            color: Colors.red,
            size: 28.0,
          ),
          imageUrl: usersModelProvider.avatar.toString(),
          boxFit: BoxFit.fill,
        ),
      ),
      title: Text(usersModelProvider.name.toString()),
      subtitle: Text(usersModelProvider.email.toString()),
      trailing: Text(
        usersModelProvider.role.toString(),
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
