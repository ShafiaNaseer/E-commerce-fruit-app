import 'package:flutter/material.dart';
import 'package:fruit_hub/screens/home_screens/controller/cart_controller.dart';
import 'package:fruit_hub/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/product_model.dart';

class CartProducts extends StatelessWidget {
  final CartController controller = Get.find<CartController>();
  CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      SizedBox(
        height: Get.height*0.74,
        child:
        ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: ((context, index) {
              return controller.products == 0 ?
               Center(child: Text("Your Cart is empty", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)):
               CartProductCart(
                controller: controller,
                product: controller.products.keys.toList()[index],
                quantity: controller.products.values.toList()[index],
                index: index,
              );
            })),
      ),
    );
  }
}

class CartProductCart extends StatelessWidget {
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;
  const CartProductCart({
    Key? key,
    required this.controller,
    required this.product,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(product.image),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(child: Text(product.name)),
          IconButton(
              onPressed: () {
                controller.removeProduct(product);
              },
              icon: Icon(
                Icons.remove_circle_outline,
                color: BackgroundColor,
              )),
          Text('${quantity}'),
          IconButton(
              onPressed: () {
                controller.addProduct(product);
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: BackgroundColor,
              )),
          SizedBox(height: 100,),
        ],
      ),
    );
  }
}
