import '../repositories/cari_repository.dart';
import '../entities/cari_entity.dart';

class CreateCari {
  final CariRepository repository;

  CreateCari(this.repository);

  Future<String> call(CariEntity cari) {
    return repository.createCari(cari);
  }
}
