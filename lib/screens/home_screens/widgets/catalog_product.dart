import '../controller/cart_controller.dart';
import '../controller/controller.dart';
import '../../../utils/imports/imports.dart';

class CatalogProduct extends StatelessWidget {
  final productController = Get.put(ProductController());
  CatalogProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
        height: 183.h,
        child: ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: productController.products.length,
        itemBuilder: (BuildContext context, int index){
      return CatalogProductCard(index: index);
    })));
  }
}

class CatalogProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final ProductController productController = Get.put(ProductController());
  final int index;
   CatalogProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 183.h,
        width: 152.w,
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(productController.products[index].image),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Positioned(
                    left: 90.w,
                    top: 0.h,
                    child: Icon(Icons.favorite_border, color: BackgroundColor,))
              ],
            ),
            SizedBox(height: 8.h,),
            SimpleText(productController.products[index].name),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("\$${productController.products[index].price}", style: TextStyle(color: BackgroundColor, fontSize: 18.sp),),
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BackgroundColor.withOpacity(0.1)
                    ),
                    child: IconButton(onPressed: (){
                      cartController.addProduct(productController.products[index]);
                    }, icon: Icon(Icons.add, color: BackgroundColor,)))
              ],
            )
          ],
        ),
      ),
    );
  }
}

