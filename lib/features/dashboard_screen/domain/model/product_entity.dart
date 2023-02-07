import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? productName;
  final String? category;
  final String? description;
  final String? productId;
  final String? image;
  final Timestamp? dateOfCreation;

  const ProductEntity(
      {this.productName,
      this.productId,
      this.category,
      this.dateOfCreation,
      this.description,
      this.image});

  @override
  List<Object?> get props =>
      [productName, category, description, productId, image, dateOfCreation];
}
