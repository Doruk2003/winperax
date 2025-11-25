import 'package:winperax/modules/teklif/domain/repositories/teklif_repository.dart';
import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';

class CreateTeklifUseCase {
  final TeklifRepository repository;

  CreateTeklifUseCase(this.repository);

  Future<String> call(TeklifEntity teklif) {
    return repository.createTeklif(teklif);
  }
}
