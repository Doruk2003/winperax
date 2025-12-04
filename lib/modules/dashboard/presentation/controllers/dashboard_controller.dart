// // FILE: lib/modules/dashboard/presentation/controllers/dashboard_controller.dart
// import 'package:get/get.dart';


// class DashboardController extends GetxController {
//   final RxInt selectedMenuIndex = 0.obs;
//   final RxBool isMenuOpen = false.obs;

//   // Yeni: Sidebar'ın dar/geniş modunu tutar
//   final RxBool isCompact = false.obs;

//   final RxMap<String, dynamic> stats = <String, dynamic>{
//     "revenue": 25430,
//     "orders": 1284,
//     "customers": 842,
//     "conversion": 4.7,
//   }.obs;

//   final RxList<double> lineData = <double>[120, 150, 180, 170, 200, 230, 210].obs;
//   final RxList<double> barData = <double>[5, 8, 6, 10, 12, 9, 11].obs;
//   final RxMap<String, double> pieData = <String, double>{
//     "Product A": 40,
//     "Product B": 30,
//     "Product C": 20,
//     "Other": 10,
//   }.obs;

//   final List<String> pageTitles = [
//     "Panel",
//     "Cari Yönetimi",
//     "Stok Yönetimi",
//     "Teklif Yönetimi",
//     "Ayarlar",
//     "Reçeteler",
//     "Parametreler",
//     "Çıkış",
//   ];

//   void changeMenu(int index) {
//     selectedMenuIndex.value = index;
//     isMenuOpen.value = false;
//   }

//   void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;

//   // Yeni: Sidebar'ı daraltma/genişletme fonksiyonu
//   void toggleCompactMode() {
//     isCompact.value = !isCompact.value;
//   }
// }

import 'package:get/get.dart';

class DashboardController extends GetxController {
  final RxInt selectedMenuIndex = 0.obs;
  final RxBool isMenuOpen = false.obs;

  // Yeni: Sidebar'ın dar/geniş modunu tutar
  final RxBool isCompact = false.obs;

  final RxMap<String, dynamic> stats = <String, dynamic>{
    "revenue": 25430,
    "orders": 1284,
    "customers": 842,
    "conversion": 4.7,
  }.obs;

  final RxList<double> lineData = <double>[120, 150, 180, 170, 200, 230, 210].obs;
  final RxList<double> barData = <double>[5, 8, 6, 10, 12, 9, 11].obs;
  final RxMap<String, double> pieData = <String, double>{
    "Product A": 40,
    "Product B": 30,
    "Product C": 20,
    "Other": 10,
  }.obs;

  final List<String> pageTitles = [
    "Panel",
    "Cari Yönetimi",
    "Stok Yönetimi",
    "Teklif Yönetimi",
    "Kullanıcı Yönetimi", // 👈 Admin için eklenen menü
    "Ayarlar",
    "Reçeteler",
    "Parametreler",
    "Çıkış",
  ];

  // ✅ Kullanıcı bilgileri
  final RxString userName = ''.obs;
  final RxString userRole = 'Kullanıcı'.obs;
  final RxBool isAdmin = false.obs;

  void changeMenu(int index) {
    selectedMenuIndex.value = index;
    isMenuOpen.value = false;
  }

  void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;

  // Yeni: Sidebar'ı daraltma/genişletme fonksiyonu
  void toggleCompactMode() {
    isCompact.value = !isCompact.value;
  }

  // ✅ Kullanıcı adı ve rolünü ayarla + isAdmin kontrolü
  void setUser(String name, String role) {
    userName.value = name;
    userRole.value = role;
    isAdmin.value = role == 'admin' || role == 'Yönetici'; // 👈 Rol kontrolü
  }
}