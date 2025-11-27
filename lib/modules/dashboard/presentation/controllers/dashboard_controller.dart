import 'package:get/get.dart';
// import 'package:flutter/material.dart';

class DashboardController extends GetxController {
  final RxInt selectedMenuIndex = 0.obs;
  final RxBool isMenuOpen = false.obs;

  // Sample stats (could be populated from domain layer later)
  final RxMap<String, dynamic> stats = <String, dynamic>{
    "revenue": 25430,
    "orders": 1284,
    "customers": 842,
    "conversion": 4.7,
  }.obs;

  // Sample time-series data for charts
  final RxList<double> lineData = <double>[
    120,
    150,
    180,
    170,
    200,
    230,
    210,
  ].obs;
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
    "Ayarlar",
    "Reçeteler",
    "Parametreler",
    "Çıkış",
  ];

  void changeMenu(int index) {
    selectedMenuIndex.value = index;
    isMenuOpen.value = false;
  }

  void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;
}
