import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    final String? productName,
    final String? category,
    final String? description,
    final String? productId,
    final String? image,
    final Timestamp? dateOfCreation,
  }) : super(
            productName: productName,
            productId: productId,
            category: category,
            description: description,
            image: image,
            dateOfCreation: dateOfCreation);

  factory ProductModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ProductModel(
        category: documentSnapshot.get('category'),
        productId: documentSnapshot.get('productId'),
        dateOfCreation: documentSnapshot.get('dateOfCreation'),
        productName: documentSnapshot.get('productName'),
        description: documentSnapshot.get('description'),
        image: documentSnapshot.get('image'));
  }

  Map<String, dynamic> toDocument() {
    return {
      "category": category,
      "dateOfCreation": dateOfCreation,
      "productId": productId,
      "productName": productName,
      "description": description,
      "image": image,
    };
  }
}
