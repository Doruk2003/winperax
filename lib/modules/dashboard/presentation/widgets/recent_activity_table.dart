import 'package:flutter/material.dart';

class RecentActivityTable extends StatelessWidget {
  const RecentActivityTable({super.key});

  List<Map<String, String>> get _rows => [
        {"id": "A001", "customer": "Ali Veli", "amount": "\$120", "status": "Done"},
        {"id": "A002", "customer": "Ayşe Y.", "amount": "\$340", "status": "Pending"},
        {"id": "A003", "customer": "Mehmet K.", "amount": "\$89", "status": "Canceled"},
        {"id": "A004", "customer": "Deniz S.", "amount": "\$540", "status": "Done"},
      ];

  // 🎨 Durum etiketleri için renk fonksiyonu
  Color getStatusColor(String status) {
    switch (status) {
      case 'Done':
        return  const Color(0xFF826CF6);// Mor
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
        child: Column(children: [
          Row(children: [
            Text('Son İşlemler', style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.download_outlined), label: const Text('Export'))
          ]),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Müşteri')),
                DataColumn(label: Text('Tutar')),
                DataColumn(label: Text('Durum')),
              ],
              rows: _rows.map((r) {
                final color = getStatusColor(r['status']!);
                return DataRow(cells: [
                  DataCell(Text(r['id']!)),
                  DataCell(Text(r['customer']!)),
                  DataCell(Text(r['amount']!)),
                  DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15), // Arka plan rengi
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      r['status']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color, // Yazı rengi
                      ),
                    ),
                  )),
                ]);
              }).toList(),
            ),
          )
        ]),
      ),
    );
  }
}