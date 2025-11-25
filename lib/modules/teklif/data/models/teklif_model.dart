import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';

class TeklifModel extends TeklifEntity {
  TeklifModel({
    required super.id,
    required super.teklifTipi,
    required super.cariId,
    required super.cariUnvan,
    super.musteriUnvan,
    super.projeAdi,
    required super.createdAt,
    required super.durum,
    required super.personelId,
    required super.personelAdSoyad,
    required super.personelEmail,
  });

  factory TeklifModel.fromMap(Map<String, dynamic> data, String documentId) {
    return TeklifModel(
      id: documentId,
      teklifTipi: data['teklifTipi'] ?? '',
      cariId: data['cariId'] ?? '',
      cariUnvan: data['cariUnvan'] ?? '',
      musteriUnvan: data['musteriUnvan'],
      projeAdi: data['projeAdi'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      durum: data['durum'] ?? '',

      personelId: data['personelId'] ?? '',
      personelAdSoyad: data['personelAdSoyad'] ?? '',
      personelEmail: data['personelEmail'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teklifTipi': teklifTipi,
      'cariId': cariId,
      'cariUnvan': cariUnvan,
      'musteriUnvan': musteriUnvan,
      'projeAdi': projeAdi,
      'createdAt': createdAt,
      'durum': durum,

      'personelId': personelId,
      'personelAdSoyad': personelAdSoyad,
      'personelEmail': personelEmail,
    };
  }
}
