import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // 👇 1. Kart: Gelir
          Expanded(
            flex: 1, // ✅ Sabit genişlik
            child: SizedBox(
              height: 90, // ✅ Yükseklik 90 piksel
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Text(
                          "+8%",
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 12),
                        ),
                      ),
                      Center( // ✅ Sayısal bilgileri center yap
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.attach_money, color: Colors.green, size: 20),
                                const SizedBox(width: 4),
                                Text("Gelir", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${controller.stats.value['revenue']}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // ✅ Kartlar arası 10 piksel boşluk

          // 👇 2. Kart: Sipariş
          Expanded(
            flex: 1, // ✅ Sabit genişlik
            child: SizedBox(
              height: 90, // ✅ Yükseklik 90 piksel
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Text(
                          "+3%",
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Center( // ✅ Sayısal bilgileri center yap
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.blue, size: 16),
                                const SizedBox(width: 4),
                                Text("Sipariş", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${controller.stats.value['orders']}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // ✅ Kartlar arası 10 piksel boşluk

          // 👇 3. Kart: Müşteri
          Expanded(
            flex: 1, // ✅ Sabit genişlik
            child: SizedBox(
              height: 90, // ✅ Yükseklik 90 piksel
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Text(
                          "+1.2%",
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Center( // ✅ Sayısal bilgileri center yap
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.people, color: Colors.orange, size: 16),
                                const SizedBox(width: 4),
                                Text("Müşteri", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${controller.stats.value['customers']}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // ✅ Kartlar arası 10 piksel boşluk

          // 👇 4. Kart: Dönüşüm
          Expanded(
            flex: 1, // ✅ Sabit genişlik
            child: SizedBox(
              height: 90, // ✅ Yükseklik 90 piksel
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Text(
                          "-0.4%",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Center( // ✅ Sayısal bilgileri center yap
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.trending_up, color: Colors.purple, size: 16),
                                const SizedBox(width: 4),
                                Text("Dönüşüm", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${controller.stats.value['conversion']}%",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}