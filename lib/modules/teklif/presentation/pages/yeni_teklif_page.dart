import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/teklif/presentation/pages/teklif_controller.dart';

class YeniTeklifPage extends StatefulWidget {
  const YeniTeklifPage({super.key});

  @override
  State<YeniTeklifPage> createState() => _YeniTeklifPageState();
}

class _YeniTeklifPageState extends State<YeniTeklifPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller
  final teklifController = Get.put(TeklifController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Teklif Oluştur")),
      body: SingleChildScrollView(
        // <-- Burası güncellendi
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            width: width > 600 ? 500 : width * 0.95,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // --------------------------------------------------------
                  // TEKLİF TİPİ
                  // --------------------------------------------------------
                  DropdownButtonFormField<String>(
                    initialValue: teklifController.teklifTipi.value.isEmpty
                        ? null
                        : teklifController.teklifTipi.value,
                    items: const [
                      DropdownMenuItem(
                        value: "Yurtiçi",
                        child: Text("Yurtiçi"),
                      ),
                      DropdownMenuItem(
                        value: "Yurtdışı",
                        child: Text("Yurtdışı"),
                      ),
                    ],
                    onChanged: (value) {
                      teklifController.teklifTipi.value = value ?? "";
                    },
                    decoration: const InputDecoration(labelText: "Teklif Tipi"),
                    validator: (v) => v == null ? "Teklif tipi seçin" : null,
                  ),

                  const SizedBox(height: 20),

                  // --------------------------------------------------------
                  // CARİ SEÇİMİ
                  // --------------------------------------------------------
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Cari Seçimi"),
                    initialValue: teklifController.selectedCariId.value.isEmpty
                        ? null
                        : teklifController
                              .selectedCariId
                              .value, // ✅ initialValue kullanıldı
                    items: [
                      // Seçim yapılmamışsa gösterilecek opsiyonel öğe
                      const DropdownMenuItem(
                        value: null,
                        child: Text("Lütfen bir cari seçin"),
                      ),
                      ...teklifController.cariList.map(
                        (cari) => DropdownMenuItem(
                          value: cari['id'].toString(), // ✅ toString() eklendi
                          child: Text(cari['unvan']),
                        ),
                      ),
                      const DropdownMenuItem(
                        value: "new_cari",
                        child: Text(
                          "+ Yeni Cari Oluştur",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == "new_cari") {
                        _showYeniCariDialog();
                      } else {
                        teklifController.selectedCariId.value =
                            value ?? ""; // ✅ .value eklendi
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Cari seçmelisiniz.";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // --------------------------------------------------------
                  // MÜŞTERİ ÜNVANI (Opsiyonel)
                  // --------------------------------------------------------
                  TextFormField(
                    controller: teklifController.unvanController,
                    decoration: const InputDecoration(
                      labelText: "Müşteri Ünvanı (İsteğe Bağlı)",
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --------------------------------------------------------
                  // PROJE ADI (Opsiyonel)
                  // --------------------------------------------------------
                  TextFormField(
                    controller: teklifController.projeAdiController,
                    decoration: const InputDecoration(
                      labelText: "Proje Adı (İsteğe Bağlı)",
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --------------------------------------------------------
                  // OLUŞTUR BUTONU
                  // --------------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final teklifId = await teklifController
                              .createTeklif();

                          Get.snackbar("Başarılı", "Teklif oluşturuldu");

                          Get.toNamed(
                            "/teklif-detay",
                            arguments: {"teklifId": teklifId},
                          );
                        }
                      },
                      child: const Text("Oluştur ve Devam Et"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // *****************************************************************************************
  // YENİ CARİ OLUŞTURMA POP-UP
  // *****************************************************************************************
  void _showYeniCariDialog() {
    final unvan = TextEditingController();
    final phone = TextEditingController();
    final mail = TextEditingController();

    Get.defaultDialog(
      title: "Yeni Cari Oluştur",
      content: Column(
        children: [
          TextField(
            controller: unvan,
            decoration: const InputDecoration(labelText: "Ünvan *"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: phone,
            decoration: const InputDecoration(labelText: "Telefon"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: mail,
            decoration: const InputDecoration(labelText: "E-posta"),
          ),
        ],
      ),
      textConfirm: "Kaydet",
      textCancel: "İptal",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        if (unvan.text.isEmpty) {
          Get.snackbar("Hata", "Ünvan zorunludur!");
          return;
        }

        // Firestore'a kayıt
        final yeniId = await teklifController.yeniCariOlustur(
          unvan.text,
          phone.text,
          mail.text,
        );

        // ✅ YENİ CARİYİ LİSTEYE EKLE
        teklifController.cariList.add({'id': yeniId, 'unvan': unvan.text});

        // ✅ DROPDOWN'A SEÇİM YAP
        setState(() {
          teklifController.selectedCariId.value = yeniId; // ✅ .value eklendi
        });

        Get.back();
      },
    );
  }
}
