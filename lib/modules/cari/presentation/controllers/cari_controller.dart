import 'package:get/get.dart';
import 'package:winperax/modules/cari/domain/entities/cari_entity.dart';
import 'package:winperax/modules/cari/domain/usecases/create_cari.dart';
import 'package:winperax/modules/cari/domain/usecases/fetch_cariler.dart';
import 'package:winperax/modules/cari/domain/usecases/update_cari.dart';
import 'package:winperax/modules/cari/domain/usecases/delete_cari.dart';

class CariController extends GetxController {
  final CreateCari createCariUseCase;
  final FetchCarilerUseCase fetchCarilerUseCase; // 🔹 güncellendi
  final UpdateCari updateCariUseCase;
  final DeleteCari deleteCariUseCase;

  CariController({
    required this.createCariUseCase,
    required this.fetchCarilerUseCase, // 🔹 constructor parametresi
    required this.updateCariUseCase,
    required this.deleteCariUseCase,
  });

  RxList<CariEntity> cariler = <CariEntity>[].obs;

  // ---------------------------------------------------------------------------
  // 🔹 Cari listesini yükle
  // ---------------------------------------------------------------------------
  Future<void> yukle() async {
    cariler.value = await fetchCarilerUseCase(); // 🔹 güncellendi
  }

  // ---------------------------------------------------------------------------
  // 🔹 Yeni cari ekle
  // ---------------------------------------------------------------------------
  Future<void> ekle(CariEntity cari) async {
    await createCariUseCase(cari);
    await yukle();
  }

  // ---------------------------------------------------------------------------
  // 🔹 Cari güncelle
  // ---------------------------------------------------------------------------
  Future<void> guncelle(CariEntity cari) async {
    await updateCariUseCase(cari);
    await yukle();
  }

  // ---------------------------------------------------------------------------
  // 🔹 Cari sil
  // ---------------------------------------------------------------------------
  Future<void> sil(String id) async {
    await deleteCariUseCase(id);
    await yukle();
  }
}
