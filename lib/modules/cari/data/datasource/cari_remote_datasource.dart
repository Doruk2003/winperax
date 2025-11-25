import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winperax/modules/cari/data/models/cari_model.dart';

class CariRemoteDataSource {
  final db = FirebaseFirestore.instance;

  Future<String> createCari(CariModel model) async {
    final doc = db.collection("cariler").doc();
    await doc.set(model.toMap());
    return doc.id;
  }

  Future<List<CariModel>> getCariList() async {
    final snapshot = await db.collection("cariler").orderBy("unvan").get();
    return snapshot.docs.map((e) => CariModel.fromMap(e.data())).toList();
  }

  Future<void> updateCari(CariModel model) async {
    await db.collection("cariler").doc(model.id).update(model.toMap());
  }

  Future<void> deleteCari(String id) async {
    await db.collection("cariler").doc(id).delete();
  }
}
