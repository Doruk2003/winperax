class TeklifEntity {
  final String id;
  final String teklifTipi;
  final String cariId;
  final String cariUnvan;
  final String? musteriUnvan; // opsiyonel
  final String? projeAdi;     // opsiyonel
  final DateTime createdAt;
  final String durum;

  const TeklifEntity({
    required this.id,
    required this.teklifTipi,
    required this.cariId,
    required this.cariUnvan,
    this.musteriUnvan,
    this.projeAdi,
    required this.createdAt,
    required this.durum,
  });
}
