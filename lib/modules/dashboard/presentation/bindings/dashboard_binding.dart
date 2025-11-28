import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}