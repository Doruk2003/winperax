// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:winperax/app/core/theme/colors.dart';
// import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
// import 'package:winperax/modules/dashboard/presentation/widgets/sidebar_item.dart';

// class SideMenu extends StatelessWidget {
//   final bool isCompact;
//   const SideMenu({super.key, required this.isCompact});

//   static const List<Map<String, dynamic>> _menuItems = [
//     {"icon": Icons.dashboard_outlined, "label": "Panel"},
//     {"icon": Icons.people_alt_outlined, "label": "Cari"},
//     {"icon": Icons.inventory_2_outlined, "label": "Stok"},
//     {"icon": Icons.receipt_long_outlined, "label": "Teklif"},
//     {"icon": Icons.settings_outlined, "label": "Ayarlar"},
//     {"icon": Icons.receipt_outlined, "label": "Reçeteler"},
//     {"icon": Icons.tune_outlined, "label": "Parametreler"},
//     {"icon": Icons.logout, "label": "Çıkış"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<DashboardController>();

//     // 🎯 Sidebar arka plan rengini burada belirleyelim
//     final sidebarBg = Theme.of(context).brightness == Brightness.dark
//         ? AppColors.sidebarDark
//         : AppColors.sidebarBgLight; // ✅ Light tema için hafif mavi-gri

//     return Container(
//       color: sidebarBg,
//       padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 8),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 96,
//             child: isCompact
//                 ? const Center(child: Icon(Icons.flutter_dash))
//                 : ThemeLogo(isCompact: isCompact),
//           ),
//           const SizedBox(height: 24),
//           const SizedBox(height: 18),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _menuItems.length,
//               itemBuilder: (ctx, index) {
//                 return Obx(() {
//                   final isSelected =
//                       controller.selectedMenuIndex.value == index;
//                   return SidebarItem(
//                     icon: _menuItems[index]['icon'],
//                     label: _menuItems[index]['label'],
//                     isSelected: isSelected,
//                     onTap: () => controller.changeMenu(index),
//                     isCompact: isCompact,
//                   );
//                 });
//               },
//             ),
//           ),
//           if (!isCompact) ...[
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Text(
//                 "Oğuz Türkyılmaz - V1.0",
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: AppColors.textColorLight,
//                 ), // ✅ Koyu gri yazı
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// // ✅ Logo için ayrı bir widget
// class ThemeLogo extends StatelessWidget {
//   final bool isCompact;

//   const ThemeLogo({super.key, required this.isCompact});

//   @override
//   Widget build(BuildContext context) {
//     // 🌞 Temaya göre logo seç
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Image.asset(
//       isDark
//           ? 'assets/images/winperax.png' // Dark theme
//           : 'assets/images/winperax_light.png', // Light theme
//       height: 90,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/app/core/theme/colors.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/sidebar_item.dart';

class SideMenu extends StatelessWidget {
  final bool isCompact;
  const SideMenu({super.key, required this.isCompact});

  // 📌 Admin menüsünü ayrı tanımlayalım
  static const Map<String, dynamic> _userManagementItem = {
    "icon": Icons.supervised_user_circle_outlined,
    "label": "Kullanıcı Yönetimi",
  };

  // 📌 Ana menü listesi (admin olmayanlar için)
  static const List<Map<String, dynamic>> _baseMenuItems = [
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

    final sidebarBg = Theme.of(context).brightness == Brightness.dark
        ? AppColors.sidebarDark
        : AppColors.sidebarBgLight;

    return Container(
      color: sidebarBg,
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 8),
      child: Obx(() {
        // ✅ isAdmin'e göre menüyü dinamik oluştur
        List<Map<String, dynamic>> menuItems = List.from(_baseMenuItems);

        // Admin ise "Ayarlar"tan sonra "Kullanıcı Yönetimi" ekle
        if (controller.isAdmin.value) {
          menuItems.insert(5, _userManagementItem); // index 5 → Ayarlar'dan sonra
        }

        return Column(
          children: [
            SizedBox(
              height: 96,
              child: isCompact
                  ? const Center(child: Icon(Icons.flutter_dash))
                  : ThemeLogo(isCompact: isCompact),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (ctx, index) {
                  final isSelected = controller.selectedMenuIndex.value == index;
                  return SidebarItem(
                    icon: menuItems[index]['icon'],
                    label: menuItems[index]['label'],
                    isSelected: isSelected,
                    onTap: () => controller.changeMenu(index),
                    isCompact: isCompact,
                  );
                },
              ),
            ),
            if (!isCompact) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "${controller.userName.value} - V1.0",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textColorLight,
                  ),
                ),
              ),
            ],
          ],
        );
      }),
    );
  }
}

// ✅ Logo için ayrı bir widget
class ThemeLogo extends StatelessWidget {
  final bool isCompact;

  const ThemeLogo({super.key, required this.isCompact});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Image.asset(
      isDark
          ? 'assets/images/winperax.png' // Dark theme
          : 'assets/images/winperax_light.png', // Light theme
      height: 90,
    );
  }
}
