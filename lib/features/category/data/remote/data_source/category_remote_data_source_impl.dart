import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/category/data/model/category_model.dart';
import 'package:dashboard/features/category/data/remote/data_source/category_remote_data_source.dart';
import 'package:dashboard/features/category/domain/model/category_entity.dart';

import '../../../../dashboard_screen/data/model/product_model.dart';
import '../../../../dashboard_screen/domain/model/product_entity.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final FirebaseFirestore firestore;
  CategoryRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addCategory(String category) async {
    final categoryCollectionRef = firestore.collection("category");
    final categoryId = categoryCollectionRef.doc().id;
    categoryCollectionRef.doc(categoryId).get().then((value) {
      if (!value.exists) {
        categoryCollectionRef.doc(categoryId).set(CategoryModel(
                category: category,
                date: Timestamp.now(),
                categoryId: categoryId)
            .toDocument() /* {"category": category, "dateOfCreation": Timestamp.now()} */);
      }
      return;
    });
  }

  @override
  Stream<List<CategoryEntity>> getCategory() {
    final categoryCollectionRef =
        firestore.collection("category").orderBy('date', descending: true);

    return categoryCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => CategoryModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    final categoryCollectionRef = firestore.collection("category");

    categoryCollectionRef.doc(categoryId).get().then((category) {
      if (category.exists) {
        categoryCollectionRef.doc(categoryId).delete();
      }
    });
  }

  @override
  Stream<List<ProductEntity>> getProduct() {
    final productCollectionRef = firestore
        .collection("products")
        .orderBy('dateOfCreation', descending: true)
        .limit(10);

    return productCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => ProductModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final productCollectionRef = firestore.collection("products");

    productCollectionRef.doc(productId).get().then((product) {
      if (product.exists) {
        productCollectionRef.doc(productId).delete();
      }
    });
  }

  @override
  Stream<List<ProductEntity>> getNextProductList(Timestamp date) {
    final productCollectionRef = firestore
        .collection("products")
        .orderBy('dateOfCreation', descending: true)
        .startAfter([date]).limit(10);

    return productCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => ProductModel.fromSnapshot(docSnap))
          .toList();
    });
  }
}
