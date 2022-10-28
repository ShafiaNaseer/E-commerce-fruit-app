import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String price;
  final String image;

  Product({required this.name,required this.price,required this.image});

  static Product fromSnapshot(DocumentSnapshot snapshot) {
   Product product = Product(name: snapshot['productName'], price: snapshot['price'], image: snapshot['image']);
    return product;
  }

}