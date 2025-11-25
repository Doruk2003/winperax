// lib/modules/teklif/pages/cari_secim_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winperax/modules/teklif/presentation/controllers/teklif_controller.dart';

class CariSecimPage extends StatefulWidget {
  const CariSecimPage({super.key});

  @override
  State<CariSecimPage> createState() => _CariSecimPageState();
}

class _CariSecimPageState extends State<CariSecimPage> {
  final TextEditingController searchController = TextEditingController();
  final teklifController = Get.find<TeklifController>();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> cariler = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> filtreliCariler = [];

  @override
  void initState() {
    super.initState();
    loadCariler();
  }

  /// Firestore'dan carileri çekme
  Future<void> loadCariler() async {
    final q = await FirebaseFirestore.instance
        .collection("cariler")
        .orderBy("ad")
        .get();

    setState(() {
      cariler = q.docs;
      filtreliCariler = List.from(cariler);
    });
  }

  /// Arama fonksiyonu
  void ara(String text) {
    text = text.toLowerCase();
    setState(() {
      filtreliCariler = cariler.where((doc) {
        final ad = doc["ad"].toString().toLowerCase();
        return ad.contains(text);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.85;

    return Scaffold(
      appBar: AppBar(title: const Text("Cari Seç")),
      body: SizedBox(
        height: height,
        child: Column(
          children: [
            // Arama alanı
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: searchController,
                onChanged: ara,
                decoration: const InputDecoration(
                  labelText: "Cari Ara",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filtreliCariler.length,
                itemBuilder: (context, index) {
                  final item = filtreliCariler[index];
                  return Card(
                    child: ListTile(
                      title: Text(item["ad"]),
                      subtitle: item.data().containsKey("telefon")
                          ? Text(item["telefon"])
                          : null,
                      onTap: () {
                        teklifController.cariController.text = item["ad"];
                        teklifController.selectedCariId.value = item.id;
                        teklifController.secilenCariAd.value = item["ad"];

                        Get.back(); // modal kapatılır
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
