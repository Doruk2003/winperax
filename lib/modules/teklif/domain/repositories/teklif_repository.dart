import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';

abstract class TeklifRepository {
  /// Yeni teklif oluşturur, Firestore ID döner
  Future<String> createTeklif(TeklifEntity teklif);

  /// Tek teklifi ID'ye göre getirir
  Future<TeklifEntity?> getTeklifById(String id);

  /// Teklifi günceller
  Future<void> updateTeklif(TeklifEntity teklif);

  /// Teklifi siler
  Future<void> deleteTeklif(String id);

  /// Listeler (örneğin bir cariye bağlı teklifler)
  Future<List<TeklifEntity>> getTeklifListByCari(String cariId);
}
