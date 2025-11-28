import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/app/shared/ui/theme/app_theme.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/app/core/controllers/theme_controller.dart';


class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(
        // ✅ AppTheme'den toolbar yüksekliğini al
        AppTheme.appBarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final themeController = Get.find<ThemeController>();

    // 🎯 Sidebar arka plan rengini al ve 1-2 ton açık hale getir
    final sidebarBg = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF111827) // SideMenu'da kullandığınız koyu renk
        : Theme.of(context).colorScheme.surface;
    // Renk tonunu 1-2 ton açığa çekmek için HSL veya HSV kullanmak daha doğru olur.
    // Basitçe, renk kanallarına küçük bir değer ekleyelim (örneğin 10-20)
    final appBarBg = sidebarBg.withRed((sidebarBg.red + 20).clamp(0, 255).toInt())
        .withGreen((sidebarBg.green + 20).clamp(0, 255).toInt())
        .withBlue((sidebarBg.blue + 20).clamp(0, 255).toInt());

    return AppBar(
      elevation: 0,
      backgroundColor: appBarBg, // ✅ Panel rengi sidebar renginin 1-2 ton açığı
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: Icon(
            controller.isCompact.value ? Icons.menu_rounded : Icons.arrow_back_ios_new_rounded,
            color: Colors.white, // İkon rengini beyaz yapalım, kontrast için
          ),
          onPressed: () {
            controller.toggleCompactMode(); // ✅ Fonksiyon çağrısı
          },
        ),
      ),
      title: Obx(() => Text(
            controller.pageTitles[controller.selectedMenuIndex.value],
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white, // Metin rengini de beyaz yapalım
            ),
          )),
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
          icon: Obx(() => Icon(
                themeController.themeMode.value == ThemeMode.light
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                color: Colors.white, // İkon rengini beyaz yapalım
              )),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
        ),
        // ✅ CircleAvatar kaldırıldı, sadece resim eklendi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            'assets/images/user.png',
            width: 36,
            height: 36,
          ),
        ),
      ],
    );
  }
}