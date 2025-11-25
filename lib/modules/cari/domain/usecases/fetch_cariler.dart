import 'package:winperax/modules/cari/domain/entities/cari_entity.dart';
import 'package:winperax/modules/cari/domain/repositories/cari_repository.dart';

class FetchCarilerUseCase {
  final CariRepository repository;

  FetchCarilerUseCase(this.repository);

  Future<List<CariEntity>> call() async {
    return await repository.fetchCariler();
  }
}
