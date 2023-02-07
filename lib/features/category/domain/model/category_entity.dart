import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? category;
  final String? categoryId;
  final Timestamp? date;

  const CategoryEntity({this.category, this.date, this.categoryId});

  @override
  List<Object?> get props => [category, date, categoryId];
}
