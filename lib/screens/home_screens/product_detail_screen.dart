

import '../../../utils/imports/imports.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key,required this.index, required this.image, required this.title, required this.price, required this.description}) : super(key: key);
  final String image;
  final String title;
  final int price;
  final String description;
  final int index;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: BackgroundColor,
        child: Column(
          children: [
            Image(image: NetworkImage(widget.image)),
            SizedBox(height: 40,),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  BoldText(widget.title),
                  Text('${widget.price}'),
                  Text(widget.description),

                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         primary: Colors.blueGrey.shade900),
                  //     onPressed: () {
                  //       dbHelper.insert(
                  //         Cart(
                  //           id: widget.index,
                  //           productId: widget.index.toString(),
                  //           productName: widget.title[widget.index],
                  //           initialPrice: widget.price,
                  //           productPrice: widget.price,
                  //           quantity: ValueNotifier(1),
                  //        //   unitTag: products[index].unit,
                  //           image: widget.image[widget.index],
                  //         ),
                  //       )
                  //           .then((value) {
                  //         cart.addTotalPrice(widget.price.toDouble());
                  //         cart.addCounter();
                  //         print('Product Added to cart');
                  //       }).onError((error, stackTrace) {
                  //         print(error.toString());
                  //       });
                  //     },
                  //     child: const Text('Add to Cart')),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
