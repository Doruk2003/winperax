import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  DashboardAppBar({super.key});
  final controller = Get.find<DashboardController>();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Obx(() {
        return Text(
          controller.pageTitles[controller.selectedMenuIndex.value],
          style: const TextStyle(
            fontSize: 18,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        );
      }),
      leading: isMobile
          ? IconButton(
              onPressed: controller.toggleMenu,
              icon: const Icon(Icons.menu_rounded),
            )
          : null,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: const AssetImage('assets/images/user.jpg'),
          ),
        ),
      ],
    );
  }
}
