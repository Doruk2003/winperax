import 'package:winperax/modules/cari/domain/entities/cari_entity.dart';

class CariModel extends CariEntity {
  CariModel({
    required super.id,
    required super.unvan,
    required super.telefon,
    required super.mail,
  });

  factory CariModel.fromMap(Map<String, dynamic> map) {
    return CariModel(
      id: map['id'],
      unvan: map['unvan'],
      telefon: map['telefon'],
      mail: map['mail'],
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "unvan": unvan, "telefon": telefon, "mail": mail};
  }
}
