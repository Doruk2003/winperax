import 'package:winperax/modules/cari/domain/repositories/cari_repository.dart';

class DeleteCari {
  final CariRepository repository;

  DeleteCari(this.repository);

  Future<void> call(String id) {
    return repository.deleteCari(id);
  }
}
