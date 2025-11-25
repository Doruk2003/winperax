import 'package:winperax/modules/cari/domain/repositories/cari_repository.dart';
import 'package:winperax/modules/cari/domain/entities/cari_entity.dart';

class UpdateCari {
  final CariRepository repository;

  UpdateCari(this.repository);

  Future<void> call(CariEntity cari) {
    return repository.updateCari(cari);
  }
}
