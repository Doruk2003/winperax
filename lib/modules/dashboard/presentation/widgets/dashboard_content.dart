import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Row(
      children: [
        // 👇 1. Kart: Gelir
        Expanded(
          child: Card(
            elevation: 0, // 👈 Görsel temizlik için
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12), // ✅ TÜM KARTLARDA AYNI PADDING
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        "Teklif",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "+8%",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${controller.stats.value['revenue']}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12), // 👈 Sabit kart arası boşluk

        // 👇 2. Kart: Sipariş
        Expanded(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12), // ✅ TÜM KARTLARDA AYNI PADDING
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.blue, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        "Sipariş",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "+3%",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${controller.stats.value['orders']}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12), // 👈 Sabit kart arası boşluk

        // 👇 3. Kart: Müşteri
        Expanded(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12), // ✅ TÜM KARTLARDA AYNI PADDING
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, color: Colors.orange, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        "Müşteri",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "+1.2%",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${controller.stats.value['customers']}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12), // 👈 Sabit kart arası boşluk

        // 👇 4. Kart: Dönüşüm
        Expanded(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12), // ✅ TÜM KARTLARDA AYNI PADDING
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.purple, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        "Dönüşüm",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "-0.4%",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${controller.stats.value['conversion']}%",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}