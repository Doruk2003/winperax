import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key, required bool isCompact});

  final DashboardController controller = Get.find();

  final List<Map<String, dynamic>> menuItems = [
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
    return Container(
      width: 260,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 40),

          Image.asset(
            "assets/images/winperax.png",
            height: 60,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final isSelected =
                      controller.selectedMenuIndex.value == index;

                  return GestureDetector(
                    onTap: () => controller.changeMenu(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            menuItems[index]["icon"],
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            menuItems[index]["label"],
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Oğuz Türkyılmaz - V1.0",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
