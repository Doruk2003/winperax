// lib/modules/teklif/controllers/teklif_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeklifController extends GetxController {
  final db = FirebaseFirestore.instance;

  // -----------------------------------------------------------------------------
  // TEXT CONTROLLERS
  // -----------------------------------------------------------------------------
  final TextEditingController cariController = TextEditingController();
  final TextEditingController unvanController = TextEditingController();
  final TextEditingController projeAdiController = TextEditingController();

  // -----------------------------------------------------------------------------
  // OBSERVABLE VARIABLES
  // -----------------------------------------------------------------------------
  RxString teklifTipi = "".obs;
  RxString selectedCariId = "".obs;
  RxString secilenCariAd = "".obs;

  // Firestore'dan gelen tüm cariler
  List<Map<String, dynamic>> cariList = [];

  // -----------------------------------------------------------------------------
  // INIT
  // -----------------------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchCariler();
  }

  // =============================================================================
  // 🔥 1. CARİ LİSTE ÇEKME
  // =============================================================================
  Future<void> fetchCariler() async {
    final query = await db.collection("cariler").orderBy("unvan").get();

    cariList = query.docs.map((e) => e.data()).toList();

    update(); // GetBuilder veya Obx için güncelleme
  }

  // =============================================================================
  // 🔥 2. YENİ CARİ OLUŞTURMA
  // =============================================================================
  Future<String> yeniCariOlustur(
    String unvan,
    String telefon,
    String mail,
  ) async {
    final doc = db.collection("cariler").doc();

    await doc.set({
      "id": doc.id,
      "unvan": unvan,
      "telefon": telefon,
      "mail": mail,
      "createdAt": DateTime.now(),
    });

    // Listeyi yenile
    await fetchCariler();

    return doc.id;
  }

  // =============================================================================
  // 🔥 3. YENİ TEKLİF OLUŞTURMA
  // =============================================================================
  Future<String> createTeklif() async {
    final teklifId = db.collection("teklifler").doc().id;

    await db.collection("teklifler").doc(teklifId).set({
      "id": teklifId,
      "teklifTipi": teklifTipi.value,
      "cariId": selectedCariId.value,
      "cariUnvan": secilenCariAd.value,
      "musteriUnvan": unvanController.text,
      "projeAdi": projeAdiController.text,
      "createdAt": DateTime.now(),
      "durum": "Aktif",
    });

    return teklifId;
  }

  // =============================================================================
  // 🔥 4. TEMİZLEME (İSTENİRSE FORM RESET)
  // =============================================================================
  void resetForm() {
    teklifTipi.value = "";
    selectedCariId.value = "";
    secilenCariAd.value = "";

    cariController.clear();
    unvanController.clear();
    projeAdiController.clear();
  }
}
