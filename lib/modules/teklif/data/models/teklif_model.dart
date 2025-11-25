import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winperax/modules/teklif/domain/entities/teklif_entity.dart';

class TeklifModel extends TeklifEntity {
  const TeklifModel({
    required super.id,
    required super.teklifTipi,
    required super.cariId,
    required super.cariUnvan,
    super.musteriUnvan,
    super.projeAdi,
    required super.createdAt,
    required super.durum,
  });

  /// Firestore → Model
  factory TeklifModel.fromMap(Map<String, dynamic> map) {
    return TeklifModel(
      id: map['id'],
      teklifTipi: map['teklifTipi'],
      cariId: map['cariId'],
      cariUnvan: map['cariUnvan'],
      musteriUnvan: map['musteriUnvan'],
      projeAdi: map['projeAdi'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      durum: map['durum'],
    );
  }

  /// Model → Map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teklifTipi': teklifTipi,
      'cariId': cariId,
      'cariUnvan': cariUnvan,
      'musteriUnvan': musteriUnvan,
      'projeAdi': projeAdi,
      'createdAt': createdAt,
      'durum': durum,
    };
  }
}
