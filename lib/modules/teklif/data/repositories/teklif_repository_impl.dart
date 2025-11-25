import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';
import 'package:winperax/modules/teklif/domain/repositories/teklif_repository.dart';
import 'package:winperax/modules/teklif/data/models/teklif_model.dart';

class TeklifRepositoryImpl implements TeklifRepository {
  final FirebaseFirestore firestore;

  TeklifRepositoryImpl(this.firestore);

  /// Ana koleksiyon
  CollectionReference get _collection => firestore.collection('teklifler');

  // ---------------------------------------------------------------------------
  // 🔥 1) YENİ TEKLİF OLUŞTURMA
  // ---------------------------------------------------------------------------
  @override
  Future<String> createTeklif(
    TeklifEntity teklif, {
    required String teklifTipi,
    required String cariId,
    required String cariUnvan,
    String? musteriUnvan,
    String? projeAdi,
    required String durum,
    required String personelId,
    required String personelAdSoyad,
    required String personelEmail,
  }) async {
    final docRef = _collection.doc();

    final model = TeklifModel(
      id: docRef.id,
      teklifTipi: teklifTipi,
      cariId: cariId,
      cariUnvan: cariUnvan,
      musteriUnvan: musteriUnvan,
      projeAdi: projeAdi,
      createdAt: DateTime.now(),
      durum: durum,
      personelId: personelId,
      personelAdSoyad: personelAdSoyad,
      personelEmail: personelEmail,
    );

    await docRef.set(model.toMap());
    return docRef.id;
  }

  // ---------------------------------------------------------------------------
  // 🔥 2) TEKLİF GETİR (ID'YE GÖRE)
  // ---------------------------------------------------------------------------
  @override
  Future<TeklifEntity?> getTeklifById(String id) async {
    final doc = await _collection.doc(id).get();

    if (!doc.exists) return null;

    return TeklifModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------------------------------------------------------------
  // 🔥 3) TÜM TEKLİFLERİ GETİR (ADMİN LİSTESİ)
  // ---------------------------------------------------------------------------
  @override
  Future<List<TeklifEntity>> getTeklifler() async {
    final query = await _collection
        .orderBy("createdAt", descending: true)
        .get();

    return query.docs
        .map(
          (doc) =>
              TeklifModel.fromMap(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // 🔥 4) CARİYE AİT TEKLİFLERİ GETİR
  // ---------------------------------------------------------------------------
  @override
  Future<List<TeklifEntity>> getTeklifListByCari(String cariId) async {
    final query = await _collection
        .where("cariId", isEqualTo: cariId)
        .orderBy("createdAt", descending: true)
        .get();

    return query.docs
        .map(
          (doc) =>
              TeklifModel.fromMap(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  // ---------------------------------------------------------------------------
  // 🔥 5) TEKLİF GÜNCELLEME
  // ---------------------------------------------------------------------------
  @override
  Future<void> updateTeklif(TeklifEntity teklif) async {
    await _collection.doc(teklif.id).update({
      'teklifTipi': teklif.teklifTipi,
      'cariId': teklif.cariId,
      'cariUnvan': teklif.cariUnvan,
      'musteriUnvan': teklif.musteriUnvan,
      'projeAdi': teklif.projeAdi,
      'durum': teklif.durum,
      'personelId': teklif.personelId,
      'personelAd': teklif.personelAdSoyad,
    });
  }

  // ---------------------------------------------------------------------------
  // 🔥 6) TEKLİF SİLME
  // ---------------------------------------------------------------------------
  @override
  Future<void> deleteTeklif(String id) async {
    await _collection.doc(id).delete();
  }
}
