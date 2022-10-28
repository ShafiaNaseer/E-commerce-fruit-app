
import 'package:get/get.dart';
import '../model/firebase_db.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;


  @override
  void onInit () {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}