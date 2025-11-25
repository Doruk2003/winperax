import 'package:winperax/modules/cari/domain/entities/cari_entity.dart';

abstract class CariRepository {
  /// Yeni cari oluştur
  Future<String> createCari(CariEntity cari);

  /// Tüm carileri getir
  Future<List<CariEntity>> fetchCariler(); // 🔹 fetchCariler eklendi

  /// Cari güncelle
  Future<void> updateCari(CariEntity cari);

  /// Cari sil
  Future<void> deleteCari(String id);
}
