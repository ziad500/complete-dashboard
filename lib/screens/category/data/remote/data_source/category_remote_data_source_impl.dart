import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/screens/category/data/model/category_model.dart';
import 'package:dashboard/screens/category/data/remote/data_source/category_remote_data_source.dart';
import 'package:dashboard/screens/category/domain/model/category_entity.dart';

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
}
