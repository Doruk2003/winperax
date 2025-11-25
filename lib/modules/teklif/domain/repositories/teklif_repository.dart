import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';

abstract class TeklifRepository {
  Future<String> createTeklif(
    TeklifEntity teklif, {
    required String teklifTipi,
    required String cariId,
    required String cariUnvan,
    String? musteriUnvan,
    String? projeAdi,
    required String durum,

    // ➕ Yeni eklenen parametreler
    required String personelId,
    required String personelAdSoyad,
    required String personelEmail,
  });

  Future<List<TeklifEntity>> getTeklifler();
}
