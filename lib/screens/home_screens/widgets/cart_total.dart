import 'package:flutter/material.dart';
import 'package:fruit_hub/screens/home_screens/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

              Text('\$${controller.total}', style: TextStyle(fontSize: 20),),
            ],
          ),
        );

    }
    );
  }
}
