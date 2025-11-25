import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:winperax/app/core/controllers/auth_controller.dart';
import 'package:winperax/app/core/controllers/theme_controller.dart';
import 'package:winperax/modules/teklif/presentation/views/offer_list_page.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        title: const Text(
          'Winperax Dashboard',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeController.themeMode.value == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              themeController.changeTheme(
                themeController.themeMode.value == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(authController: authController),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hoşgeldiniz',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                // Kartlar 1'er 1'er aşağı doğru
                Column(
                  children: [
                    DashboardCard(
                      title: 'Günlük Teklif Sayısı',
                      value: '0',
                      icon: Icons.inventory,
                    ),
                    const SizedBox(height: 16),
                    DashboardCard(
                      title: 'Günlük Teklif Toplamı',
                      value: '0',
                      icon: Icons.people,
                    ),
                    const SizedBox(height: 16),
                    DashboardCard(
                      title: 'Aylık Teklif Sayısı',
                      value: '0',
                      icon: Icons.remove_shopping_cart,
                      backgroundColor: const Color(0xFF66BB6A),
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    DashboardCard(
                      title: 'Aylık Teklif Toplamı',
                      value: '0',
                      icon: Icons.document_scanner,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Grafik burada
                // _PieChartWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Pie Chart Widget
// class _PieChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text('Proje Dağılımı'),
//             SizedBox(
//               height: 125,
//               child: PieChart(
//                 PieChartData(
//                   sections: [
//                     PieChartSectionData(
//                       value: 70,
//                       color: Colors.blue,
//                       title: 'Yurtiçi Proje',
//                     ),
//                     PieChartSectionData(
//                       value: 30,
//                       color: Colors.green,
//                       title: 'Yurtdışı Proje',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// DashboardCard widget'ı güncellendi
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? backgroundColor;
  final Color? textColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    // Card genişliği: Sayfa genişliğinden 32px az
    final double cardWidth = MediaQuery.of(context).size.width - 32;

    return SizedBox(
      width: cardWidth,
      height: 110, // Sabit yükseklik
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Sol tarafta ikon
              CircleAvatar(
                backgroundColor: textColor == Colors.white
                    ? Colors.white
                    : const Color(0xFF66BB6A),
                radius: 24,
                child: Icon(
                  icon,
                  color: textColor == Colors.white
                      ? const Color(0xFF66BB6A)
                      : Colors.white,
                ),
              ),
              const SizedBox(width: 14), // İkon ile rakam arasında boşluk
              // Orta kısımda rakam (center)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// AppDrawer widget'ı güncellendi
class AppDrawer extends StatelessWidget {
  final AuthController authController;

  const AppDrawer({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Drawer'ı sayfayı tamamen kaplamak için yüksekliği ayarla
      child: SizedBox(
        height: MediaQuery.of(
          context,
        ).size.height, // 👈 Sayfanın tam yüksekliği
        child: Column(
          children: [
            // DrawerHeader (Logo ile)
            Container(
              width: double.infinity,
              height: 150, // 👈 Sabit yükseklik (eski: 120px)
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B), // 👈 Tek renk arka plan
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(
                    0xFF1E293B,
                  ), // 👈 Aynı rengi DrawerHeader'a da uyguladık
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Center(
                  child: Image.asset(
                    'assets/images/winperax.png', // 👈 Logo yolu
                    width: 180,
                    height: 60, // 👈 Logo yüksekliği düşürüldü
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // Menü öğeleri
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home, color: const Color(0xFF66BB6A)),
                    title: Text(
                      'Panel',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () => Get.back(),
                  ),

                  ListTile(
                    leading: Icon(Icons.person, color: const Color(0xFF66BB6A)),
                    title: Text(
                      'Cari',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () => Get.back(),
                  ),

                  ListTile(
                    leading: Icon(Icons.apple, color: const Color(0xFF66BB6A)),
                    title: Text(
                      'Stok',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () => Get.back(),
                  ),

                  // 🔥 TEKLİF – Doğru yönlendirmeyle güncel HALİ
                  ListTile(
                    leading: Icon(Icons.recycling, color: Colors.white),
                    title: Text(
                      'Teklif',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                    tileColor: const Color(0xFF66BB6A),

                    /// 👇 **Menü kapanacak → Teklif Listesi açılacak**
                    onTap: () {
                      Get.back(); // Drawer'ı kapat
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Get.to(
                          () => const TeklifListesiPage(),
                        ); // Teklif Listesi aç
                      });
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: const Color(0xFF66BB6A),
                    ),
                    title: Text(
                      'Ayarlar',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () => Get.back(),
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.event_note,
                      color: const Color(0xFF66BB6A),
                    ),
                    title: Text(
                      'Reçeteler',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () => Get.back(),
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.manage_accounts,
                      color: const Color(0xFF66BB6A),
                    ),
                    title: Text(
                      'Parametreler',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () => Get.back(),
                  ),

                  const Spacer(),

                  ListTile(
                    leading: Icon(Icons.logout, color: const Color(0xFF66BB6A)),
                    title: Text(
                      'Çıkış',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    onTap: () {
                      authController.signOut(context);
                    },
                  ),
                ],
              ),
            ),

            // Altta Versiyon 1.1 yazan siyah bant
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B), // 👈 Siyah bant rengi
              ),
              child: Center(
                child: Text(
                  'By Oğuz Türkyılmaz - Version 1.0',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[300],
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:demo_app/controllers/auth_controller.dart';
// import 'package:demo_app/controllers/theme_controller.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();
//     final themeController = Get.find<ThemeController>();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1E293B),
//         foregroundColor: Colors.white,
//         title: const Text(
//           'Winperax Dashboard',
//           style: TextStyle(
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//               themeController.themeMode.value == ThemeMode.dark
//                   ? Icons.light_mode
//                   : Icons.dark_mode,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               themeController.changeTheme(
//                 themeController.themeMode.value == ThemeMode.dark
//                     ? ThemeMode.light
//                     : ThemeMode.dark,
//               );
//             },
//           ),
//         ],
//       ),
//       drawer: AppDrawer(authController: authController),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           // 👈 Yeni: ScrollView eklendi
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Hoşgeldiniz',
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Kartlar 1'er 1'er aşağı doğru
//                 Column(
//                   children: [
//                     DashboardCard(
//                       title: 'Günlük Teklif Sayısı',
//                       value: '0',
//                       icon: Icons.inventory,
//                     ),
//                     const SizedBox(height: 16),
//                     DashboardCard(
//                       title: 'Günlük Teklif Toplamı',
//                       value: '0',
//                       icon: Icons.people,
//                     ),
//                     const SizedBox(height: 16),
//                     DashboardCard(
//                       title: 'Aylık Teklif Sayısı',
//                       value: '0',
//                       icon: Icons.remove_shopping_cart,
//                       backgroundColor: const Color(0xFF66BB6A),
//                       textColor: Colors.white,
//                     ),
//                     const SizedBox(height: 16),
//                     DashboardCard(
//                       title: 'Aylık Teklif Toplamı',
//                       value: '0',
//                       icon: Icons.document_scanner,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 // Grafik burada
//                 _PieChartWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Pie Chart Widget
// class _PieChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text('Proje Dağılımı'),
//             SizedBox(
//               height: 150,
//               child: PieChart(
//                 PieChartData(
//                   sections: [
//                     PieChartSectionData(
//                       value: 30,
//                       color: Colors.blue,
//                       title: 'Yurtiçi Proje',
//                     ),
//                     PieChartSectionData(
//                       value: 30,
//                       color: Colors.green,
//                       title: 'Yurtdışı Proje',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // DashboardCard widget'ı aynı kalır
// // DashboardCard widget'ı güncellendi
// class DashboardCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color? backgroundColor;
//   final Color? textColor;

//   const DashboardCard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//     this.backgroundColor = Colors.white,
//     this.textColor = Colors.black,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Card genişliği: Sayfa genişliğinden 32px az
//     final double cardWidth = MediaQuery.of(context).size.width - 32;

//     return SizedBox(
//       width: cardWidth,
//       height: 110, // Sabit yükseklik
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         color: backgroundColor,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               // Sol tarafta ikon
//               CircleAvatar(
//                 backgroundColor: textColor == Colors.white
//                     ? Colors.white
//                     : const Color(0xFF66BB6A),
//                 radius: 24,
//                 child: Icon(
//                   icon,
//                   color: textColor == Colors.white
//                       ? const Color(0xFF66BB6A)
//                       : Colors.white,
//                 ),
//               ),
//               const SizedBox(width: 14), // İkon ile rakam arasında boşluk
//               // Orta kısımda rakam (center)
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       value,
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.normal,
//                         color: textColor,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       title,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: textColor,
//                         fontFamily: 'Montserrat',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // AppDrawer widget'ı (eski hali - sadece logo ve versiyon için)
// // AppDrawer widget'ı güncellendi
// class AppDrawer extends StatelessWidget {
//   final AuthController authController;

//   const AppDrawer({super.key, required this.authController});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       // Drawer'ı sayfayı tamamen kaplamak için yüksekliği ayarla
//       child: SizedBox(
//         height: MediaQuery.of(
//           context,
//         ).size.height, // 👈 Sayfanın tam yüksekliği
//         child: Column(
//           children: [
//             // DrawerHeader (Logo ile)
//             Container(
//               width: double.infinity,
//               height: 120, // 👈 Sabit yükseklik (eski: 120px)
//               decoration: const BoxDecoration(),
//               child: DrawerHeader(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
//                 ),
//                 ),
//                 margin: EdgeInsets.zero,
//                 padding: EdgeInsets.zero,
//                 child: Center(
//                   child: Image.asset(
//                     'assets/images/winperax.png', // 👈 Logo yolu
//                     width: 180,
//                     height: 45, // 👈 Logo yüksekliği düşürüldü
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             // Menü öğeleri
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   ListTile(
//                     leading: Icon(
//                       Icons.home,
//                       color: const Color(0xFF66BB6A),
//                     ), // 👈 İkon rengi yeşil
//                     title: Text(
//                       'Panel',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     onTap: () => Get.back(),
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.person,
//                       color: const Color(0xFF66BB6A),
//                     ), // 👈 İkon rengi yeşil
//                     title: Text(
//                       'Cari',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     onTap: () => Get.back(),
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.inventory,
//                       color: const Color(0xFF66BB6A),
//                     ), // 👈 İkon rengi yeşil
//                     title: Text(
//                       'Stok',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     onTap: () => Get.back(),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.recycling, color: Colors.white),
//                     title: Text(
//                       'Teklif',
//                       style: TextStyle(
//                         fontFamily: 'Montserrat',
//                         color: Colors.white,
//                       ),
//                     ),
//                     tileColor: const Color(0xFF66BB6A),
//                     onTap: () => Get.back(),
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.settings,
//                       color: const Color(0xFF66BB6A),
//                     ), // 👈 İkon rengi yeşil
//                     title: Text(
//                       'Ayarlar',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     onTap: () => Get.back(),
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.event_note,
//                       color: const Color(0xFF66BB6A),
//                     ), // 👈 İkon rengi yeşil
//                     title: Text(
//                       'Reçeteler',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     onTap: () => Get.back(),
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.manage_accounts,
//                       color: const Color(0xFF66BB6A),
//                     ), // 👈 İkon rengi yeşil
//                     title: Text(
//                       'Parametreler',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     onTap: () => Get.back(),
//                   ),
//                   const Spacer(),
//                   ListTile(
//                     leading: Icon(
//                       Icons.logout,
//                       color: const Color(0xFF66BB6A),
//                     ), // 👈 İkon rengi yeşil
//                     title: Text(
//                       'Çıkış',
//                       style: TextStyle(fontFamily: 'Montserrat'),
//                     ),
//                     onTap: () {
//                       authController.signOut(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             // Altta Versiyon 1.1 yazan siyah bant
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF1E293B), // 👈 Siyah bant rengi
//               ),
//               child: Center(
//                 child: Text(
//                   'By Oğuz Türkyılmaz - Version 1.0',
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontWeight: FontWeight.w300,
//                     color: Colors.grey[300],
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
