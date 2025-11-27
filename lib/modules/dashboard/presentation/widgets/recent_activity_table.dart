import 'package:flutter/material.dart';

class RecentActivityTable extends StatelessWidget {
  const RecentActivityTable({super.key});

  // sample rows
  List<Map<String, String>> get rows => [
    {"id": "A001", "customer": "Ali Veli", "amount": "\$120", "status": "Done"},
    {
      "id": "A002",
      "customer": "Ayşe Y.",
      "amount": "\$340",
      "status": "Pending",
    },
    {
      "id": "A003",
      "customer": "Mehmet K.",
      "amount": "\$89",
      "status": "Canceled",
    },
    {"id": "A004", "customer": "Deniz S.", "amount": "\$540", "status": "Done"},
  ];

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
                  'Son İşlemler',
                  style: Theme.of(context).textTheme.titleLarge,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Müşteri')),
                  DataColumn(label: Text('Tutar')),
                  DataColumn(label: Text('Durum')),
                ],
                rows: rows
                    .map(
                      (r) => DataRow(
                        cells: [
                          DataCell(Text(r['id']!)),
                          DataCell(Text(r['customer']!)),
                          DataCell(Text(r['amount']!)),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: r['status'] == 'Done'
                                    ? Colors.green.withValues(alpha: 0.12)
                                    : r['status'] == 'Pending'
                                    ? Colors.amber.withValues(alpha: 0.12)
                                    : Colors.red.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                r['status']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
