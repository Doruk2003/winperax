import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winperax/modules/cari/domain/entities/cari_entity.dart';
import 'package:winperax/modules/cari/domain/repositories/cari_repository.dart';

class CariRepositoryImpl implements CariRepository {
  final FirebaseFirestore firestore;

  CariRepositoryImpl(this.firestore);

  CollectionReference get _collection => firestore.collection('cariler');

  // ---------------------------------------------------------------------------
  // 🔹 Tüm carileri getir
  // ---------------------------------------------------------------------------
  @override
  Future<List<CariEntity>> fetchCariler() async {
    final query = await _collection.orderBy('unvan').get();

    return query.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return CariEntity(
        id: doc.id,
        unvan: data['unvan'] ?? '',
        telefon: data['telefon'] ?? '',
        mail: data['mail'] ?? '',
      );
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // 🔹 Yeni cari oluştur
  // ---------------------------------------------------------------------------
  @override
  Future<String> createCari(CariEntity cari) async {
    final docRef = _collection.doc();
    await docRef.set({
      'unvan': cari.unvan,
      'telefon': cari.telefon,
      'mail': cari.mail,
      'createdAt': DateTime.now(),
    });
    return docRef.id;
  }

  // ---------------------------------------------------------------------------
  // 🔹 Cari güncelle
  // ---------------------------------------------------------------------------
  @override
  Future<void> updateCari(CariEntity cari) async {
    await _collection.doc(cari.id).update({
      'unvan': cari.unvan,
      'telefon': cari.telefon,
      'mail': cari.mail,
    });
  }

  // ---------------------------------------------------------------------------
  // 🔹 Cari sil
  // ---------------------------------------------------------------------------
  @override
  Future<void> deleteCari(String id) async {
    await _collection.doc(id).delete();
  }
}
