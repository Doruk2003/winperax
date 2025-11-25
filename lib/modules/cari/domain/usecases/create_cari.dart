import 'package:winperax/modules/cari/domain/repositories/cari_repository.dart';

class CreateCariUseCase {
  final CariRepository repository;

  CreateCariUseCase(this.repository);

  Future<String> call({
    required String unvan,
    required String telefon,
    required String mail,
  }) {
    return repository.createCari(
      unvan: unvan,
      telefon: telefon,
      mail: mail,
    );
  }
}
