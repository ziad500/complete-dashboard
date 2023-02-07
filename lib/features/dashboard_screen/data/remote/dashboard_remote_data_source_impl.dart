import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/dashboard_screen/data/model/product_model.dart';
import 'package:dashboard/features/dashboard_screen/domain/model/product_entity.dart';

import 'dashboard_remote_data_source.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final FirebaseFirestore firestore;
  DashboardRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addProduct(ProductEntity productEntity) async {
    final productCollectionRef = firestore.collection("products");
    final productId = productCollectionRef.doc().id;
    productCollectionRef.doc(productId).get().then((value) {
      if (!value.exists) {
        productCollectionRef.doc(productId).set(ProductModel(
                category: productEntity.category,
                dateOfCreation: Timestamp.now(),
                description: productEntity.description,
                image: productEntity.image,
                productId: productId,
                productName: productEntity.productName)
            .toDocument());
      }
      return;
    });
  }
}
