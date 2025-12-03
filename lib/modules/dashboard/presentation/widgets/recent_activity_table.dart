import 'package:flutter/material.dart';
import 'package:winperax/app/core/theme/colors.dart'; // ✅ AppColors'ı içe aktar

class RecentActivityTable extends StatelessWidget {
  const RecentActivityTable({super.key});

  List<Map<String, String>> get _rows => [
    {
      "id": "A001",
      "date": "10.10.2025",
      "offerNo": "W-000001",
      "customer": "Esvera Cam",
      "project": "Ayten ŞEN",
      "M2": "80",
      "amount": "\$120",
      "created": "Oğuz TÜRKYILMAZ",
      "status": "Done",
    },
    {
      "id": "A002",
      "date": "10.12.2025",
      "offerNo": "W-000002",
      "customer": "Uslu Dış Ticaret",
      "project": "Doruk TÜRKYILMAZ",
      "M2": "160",
      "amount": "\$340",
      "created": "Oğuz TÜRKYILMAZ",
      "status": "Pending",
    },
    {
      "id": "A003",
      "date": "10.12.2025",
      "offerNo": "W-000003",
      "customer": "SGA Yapı",
      "project": "Gülcan TÜRKYILMAZ",
      "M2": "65",
      "amount": "\$89",
      "created": "Oğuz TÜRKYILMAZ",
      "status": "Canceled",
    },
    {
      "id": "A004",
      "date": "15.10.2025",
      "offerNo": "W-000004",
      "customer": "ALC Metal",
      "project": "Atilla ÇAKILKAYA",
      "M2": "175",
      "amount": "\$540",
      "created": "Oğuz TÜRKYILMAZ",
      "status": "Done",
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Done':
        return const Color(0xFF826CF6); // Mor
      case 'Pending':
        return const Color(0xFFFF9900); // 🟠 Turuncu
      case 'Canceled':
        return const Color(0xFFF03869); // 🌸 Fuşya
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Bu Ay Verilen Teklifler',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Export'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  columns: [
                    DataColumn(
                      label: Container(
                        width: 60, // ✅ ID sütunu daraltıldı
                        alignment: Alignment.centerLeft,
                        child: Text('ID'),
                      ),
                    ),
                    DataColumn(label: Text('Tarih')),
                    DataColumn(label: Text('Teklif No')),
                    DataColumn(label: Text('Müşteri')),
                    DataColumn(label: Text('Proje Adı')),
                    DataColumn(label: Text('M2')), // ✅ Sağda hizalanacak
                    DataColumn(label: Text('Tutar')), // ✅ Sağda hizalanacak
                    DataColumn(label: Text('Hazırlayan')),
                    DataColumn(
                      label: Container(
                        width: 90, // Durum sütunu
                        alignment: Alignment.centerLeft,
                        child: Text('Durum'),
                      ),
                    ),
                  ],
                  rows: _rows.map((r) {
                    final color = getStatusColor(r['status']!);
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            height: 36,
                            width: 50, // ✅ ID sütunu daraltıldı
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['id']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['date']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['offerNo']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['customer']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['project']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerRight, // ✅ Sağa dayalı
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['M2']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerRight, // ✅ Sağa dayalı
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['amount']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              r['created']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            height: 36,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                r['status']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: color,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}