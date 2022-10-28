import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_model.dart';

class FirestoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Stream<List<Product>> getAllProducts () {

    return _firebaseFirestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((docs) => Product.fromSnapshot(docs)).toList();
    });
  }
}