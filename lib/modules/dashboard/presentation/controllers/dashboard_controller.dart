import 'package:get/get.dart';

class DashboardController extends GetxController {
  final RxInt selectedMenuIndex = 0.obs;

  void changeMenu(int index) {
    selectedMenuIndex.value = index;
  }
}
// TODO Implement this library.