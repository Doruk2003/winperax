import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';
import 'package:winperax/modules/teklif/domain/repositories/teklif_repository.dart';
import 'package:winperax/modules/teklif/data/models/teklif_model.dart';

class TeklifRepositoryImpl implements TeklifRepository {
  final FirebaseFirestore firestore;

  TeklifRepositoryImpl(this.firestore);

  CollectionReference get _collection =>
      firestore.collection('teklifler'); // ana koleksiyon

  @override
  Future<String> createTeklif(TeklifEntity teklif) async {
    final docRef = _collection.doc();

    final model = TeklifModel(
      id: docRef.id,
      teklifTipi: teklif.teklifTipi,
      cariId: teklif.cariId,
      cariUnvan: teklif.cariUnvan,
      musteriUnvan: teklif.musteriUnvan,
      projeAdi: teklif.projeAdi,
      createdAt: DateTime.now(),
      durum: teklif.durum,
    );

    await docRef.set(model.toMap());
    return docRef.id;
  }

  @override
  Future<TeklifEntity?> getTeklifById(String id) async {
    final doc = await _collection.doc(id).get();

    if (!doc.exists) return null;

    return TeklifModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  @override
  Future<void> updateTeklif(TeklifEntity teklif) async {
    await _collection.doc(teklif.id).update({
      'teklifTipi': teklif.teklifTipi,
      'cariId': teklif.cariId,
      'cariUnvan': teklif.cariUnvan,
      'musteriUnvan': teklif.musteriUnvan,
      'projeAdi': teklif.projeAdi,
      'durum': teklif.durum,
    });
  }

  @override
  Future<void> deleteTeklif(String id) async {
    await _collection.doc(id).delete();
  }

  @override
  Future<List<TeklifEntity>> getTeklifListByCari(String cariId) async {
    final query = await _collection
        .where("cariId", isEqualTo: cariId)
        .orderBy("createdAt", descending: true)
        .get();

    return query.docs
        .map((doc) =>
            TeklifModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
