import 'package:winperax/modules/teklif/domain/repositories/teklif_repository.dart';
import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';

class CreateTeklifUseCase {
  final TeklifRepository repository;

  CreateTeklifUseCase(this.repository);

  Future<String> call({
    required String teklifTipi,
    required String cariId,
    required String cariUnvan,
    String? musteriUnvan,
    String? projeAdi,
    required String personelAdSoyad,
    required String personelId,
    required String personelEmail,
    required String durum,
  }) {
    // Repository'nin beklediği entity oluşturuluyor
    final teklif = TeklifEntity(
      id: '', // Firestore otomatik verecek
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

    return repository.createTeklif(
      teklif,
      teklifTipi: '',
      cariId: '',
      cariUnvan: '',
      durum: '',
      personelId: '',
      personelAdSoyad: '',
      personelEmail: '',
    );
  }
}
