import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/app/core/controllers/theme_controller.dart';
import 'package:winperax/app/core/theme/app_theme.dart';
import 'package:winperax/app/core/theme/colors.dart'; // ✅ AppColors'ı içe aktar

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppTheme.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final themeController = Get.find<ThemeController>();

    // 🎯 Panel arka plan rengini sidebar ile aynı yap
    final appBarBg = Theme.of(context).brightness == Brightness.dark
        ? AppColors
              .sidebarDark // ✅ Dark tema: sidebarDark
        : AppColors.sidebarBgLight; // ✅ Light tema: sidebarBgLight

    // ✅ Temaya göre ikon rengini belirle
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.textColorLight; // ✅ Light tema için koyu gri

    return AppBar(
      elevation: 0,
      backgroundColor: appBarBg, // ✅ Panel rengi artık sidebar ile aynı
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: Icon(
            controller.isCompact.value
                ? Icons.menu_open_rounded
                : Icons.menu_open_rounded,
            color: iconColor,
            size: 32, // ✅ İkon boyutunu büyüttük
          ),
          onPressed: () {
            controller.toggleCompactMode();
          },
        ),
      ),
      title: Obx(
        () => Text(
          controller.pageTitles[controller.selectedMenuIndex.value],
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: iconColor,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            final currentTheme = themeController.themeMode.value;
            if (currentTheme == ThemeMode.light) {
              themeController.changeTheme(ThemeMode.dark);
            } else {
              themeController.changeTheme(ThemeMode.light);
            }
          },
          icon: Obx(
            () => Icon(
              themeController.themeMode.value == ThemeMode.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              color: iconColor,
              size: 24,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_rounded,
            color: iconColor,
            size: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset('assets/images/user.png', width: 36, height: 36),
        ),
      ],
    );
  }
}
