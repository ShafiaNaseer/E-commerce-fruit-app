
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_hub/screens/home_screens/widgets/cart_product.dart';
import 'package:fruit_hub/screens/home_screens/widgets/cart_total.dart';
import 'package:fruit_hub/utils/imports/imports.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants.dart';
import '../controller/cart_controller.dart';



class CartScreen extends StatefulWidget {
  const CartScreen({
  Key? key,
}) : super(key: key);

@override
State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  final CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Shopping Cart'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            CartProducts(),
            CartTotal(),

          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: BackgroundColor,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
//
// class PlusMinusButtons extends StatelessWidget {
//   final VoidCallback deleteQuantity;
//   final VoidCallback addQuantity;
//   final String text;
//   const PlusMinusButtons(
//       {Key? key,
//         required this.addQuantity,
//         required this.deleteQuantity,
//         required this.text})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
//         Text(text),
//         IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
//       ],
//     );
//   }
// }
//
// class ReusableWidget extends StatelessWidget {
//   final String title, value;
//   const ReusableWidget({Key? key, required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           Text(
//             value.toString(),
//             style: Theme.of(context).textTheme.subtitle2,
//           ),
//         ],
//       ),
//     );
//   }
// }