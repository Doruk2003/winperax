import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  final int menuIndex;

  const DashboardContent({super.key, required this.menuIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: IndexedStack(
        index: menuIndex,
        children: const [
          Center(child: Text("Dashboard Panel")),
          Center(child: Text("Cari Yönetimi")),
          Center(child: Text("Stok Ekranı")),
          Center(child: Text("Teklif Yönetimi")),
          Center(child: Text("Ayarlar")),
          Center(child: Text("Reçeteler")),
          Center(child: Text("Parametre Ayarları")),
          Center(child: Text("Çıkış")),
        ],
      ),
    );
  }
}
