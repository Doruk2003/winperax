// import 'package:flutter/material.dart';

  //   @override
  //   Widget build(BuildContext context) {
  //     final bg = Theme.of(context).cardColor;
  //     return Card(
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 // 👉 İkon (boyutu 2 katına çıkarıldı)
  //                 CircleAvatar(
  //                   radius: 32, // çap 64 piksel → mevcutun ~2 katı
  //                   backgroundColor: (color ?? Theme.of(context).colorScheme.primary)
  //                       .withValues(alpha: 0.12),
  //                   child: Icon(
  //                     icon,
  //                     color: color ?? Theme.of(context).colorScheme.primary,
  //                     size: 32, // ikon da 2 kat büyük
  //                   ),
  //                 ),
  //                 const SizedBox(width: 20),
  //                 Expanded(
  //                   child: Row(
  //                     children: [
  //                       // 👉 Başlık (soluna dayalı)
  //                       Text(
  //                         title,
  //                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                       ),
  //                       const Spacer(), // 👈 Arayı doldur, yüzdeyi sağa it
  //                       // 👉 Yüzde bilgisi (sağa dayalı)
  //                       Text(
  //                         delta,
  //                         style: TextStyle(
  //                           color: delta.startsWith('-') ? Colors.red : Colors.green,
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 8), // metinler arası boşluk
  //             // 👉 Rakamsal değer (mevcut yerinde kalıyor)
  //             Text(
  //               value,
  //               style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //                     fontFamily: "Montserrat",
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
// class StatCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;
//   final String delta;

//   const StatCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.value,
//     required this.delta,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 32,
//                   backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                   child: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
//                       const Spacer(),
//                       Text(delta, style: TextStyle(color: delta.startsWith('-') ? Colors.red : Colors.green, fontWeight: FontWeight.w600)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: "Montserrat", fontWeight: FontWeight.w700)),
//           ],
//         ),
//       ),
//     );
//   }
// }