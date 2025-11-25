class TeklifEntity {
  final String id;
  final String teklifTipi;
  final String cariId;
  final String cariUnvan;
  final String? musteriUnvan;
  final String? projeAdi;
  final DateTime createdAt;
  final String durum;

  // ➕ Yeni Eklenenler
  final String personelId;
  final String personelAdSoyad;
  final String personelEmail;

  const TeklifEntity({
    required this.id,
    required this.teklifTipi,
    required this.cariId,
    required this.cariUnvan,
    this.musteriUnvan,
    this.projeAdi,
    required this.createdAt,
    required this.durum,

    // ➕ Yeni zorunlu parametreler
    required this.personelId,
    required this.personelAdSoyad,
    required this.personelEmail,
  });
}
