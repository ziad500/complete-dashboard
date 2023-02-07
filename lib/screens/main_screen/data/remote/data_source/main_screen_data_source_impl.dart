import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/screens/main_screen/data/remote/data_source/main_screen_data_source.dart';

class MainScreenRemoteDataSourceImpl implements MainScreenRemoteDataSource {
  final FirebaseFirestore firestore;
  MainScreenRemoteDataSourceImpl(this.firestore);

  @override
  Future<int> getCategoryCount() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('category').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }
}
