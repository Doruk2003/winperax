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

  // 🎨 Durum etiketleri için renk fonksiyonu
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
            const SizedBox(height: 12),
            // 👇 Tabloyu Scrollable yap
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: TextStyle(
                    color: AppColors.primaryColor, // ✅ Başlık rengi: primaryColor (mor)
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Tarih')),
                    DataColumn(label: Text('Teklif No')),
                    DataColumn(label: Text('Müşteri')),
                    DataColumn(label: Text('Proje Adı')),
                    DataColumn(label: Text('M2')),
                    DataColumn(label: Text('Tutar')),
                    DataColumn(label: Text('Hazırlayan')),
                    DataColumn(label: Text('Durum')),
                  ],
                  rows: _rows.map((r) {
                    final color = getStatusColor(r['status']!);
                    return DataRow(
                      cells: [
                        DataCell(Text(r['id']!)),
                        DataCell(Text(r['date']!)),
                        DataCell(Text(r['offerNo']!)),  
                        DataCell(Text(r['customer']!)),
                        DataCell(
                          Text(
                            r['project']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DataCell(Text(r['M2']!)),
                        DataCell(Text(r['amount']!)),
                        DataCell(Text(r['created']!)),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15), // Arka plan rengi
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              r['status']!,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: color, // Yazı rengi
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