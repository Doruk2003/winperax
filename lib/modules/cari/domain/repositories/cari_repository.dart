abstract class CariRepository {
  Future<String> createCari({
    required String unvan,
    required String telefon,
    required String mail,
  });
}
