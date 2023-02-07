import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel(
      {final String? category, final Timestamp? date, final String? categoryId})
      : super(category: category, date: date, categoryId: categoryId);

  factory CategoryModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return CategoryModel(
        category: documentSnapshot.get('category'),
        categoryId: documentSnapshot.get('categoryId'),
        date: documentSnapshot.get('date'));
  }

  Map<String, dynamic> toDocument() {
    return {"category": category, "date": date, "categoryId": categoryId};
  }
}
