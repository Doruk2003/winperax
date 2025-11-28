import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/sidebar_item.dart'; // 👈 Ekle

class SideMenu extends StatelessWidget {
  final bool isCompact;
  const SideMenu({super.key, required this.isCompact});

  static const List<Map<String, dynamic>> _menuItems = [
    {"icon": Icons.dashboard_outlined, "label": "Panel"},
    {"icon": Icons.people_alt_outlined, "label": "Cari"},
    {"icon": Icons.inventory_2_outlined, "label": "Stok"},
    {"icon": Icons.receipt_long_outlined, "label": "Teklif"},
    {"icon": Icons.settings_outlined, "label": "Ayarlar"},
    {"icon": Icons.receipt_outlined, "label": "Reçeteler"},
    {"icon": Icons.tune_outlined, "label": "Parametreler"},
    {"icon": Icons.logout, "label": "Çıkış"},
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    // 🎯 Sidebar arka plan rengini burada belirleyelim
    final sidebarBg = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF111827) // Daha koyu
        : Theme.of(context).colorScheme.surface;

    return Container(
      color: sidebarBg,
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: 96,
            child: isCompact
                ? const Center(child: Icon(Icons.flutter_dash))
                : Image.asset('assets/images/winperax.png', height: 90),
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (ctx, index) {
                return Obx(() {
                  final isSelected =
                      controller.selectedMenuIndex.value == index;
                  return SidebarItem(
                    icon: _menuItems[index]['icon'],
                    label: _menuItems[index]['label'],
                    isSelected: isSelected,
                    onTap: () => controller.changeMenu(index),
                    isCompact: isCompact,
                  );
                });
              },
            ),
          ),
          if (!isCompact) ...[
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Oğuz Türkyılmaz - V1.0",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
