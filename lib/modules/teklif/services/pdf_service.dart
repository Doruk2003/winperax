import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui' as ui; // 👈 Bu satır eklendi

class PdfService {
  static Future<String> createOfferPdf({
    required String offerTitle,
    required String offerContent,
  }) async {
    final PdfDocument document = PdfDocument();

    // Başlık yazdır
    document.pages.add().graphics.drawString(
      offerTitle,
      PdfStandardFont(PdfFontFamily.helvetica, 24),
      bounds: ui.Rect.fromLTWH(0, 0, 300, 30), // 👈 ui.Rect olarak kullanıldı
    );

    // İçerik yazdır
    document.pages.add().graphics.drawString(
      offerContent,
      PdfStandardFont(PdfFontFamily.helvetica, 16),
      bounds: ui.Rect.fromLTWH(0, 50, 300, 100), // 👈 ui.Rect olarak kullanıldı
    );

    final List<int> bytes = await document.save();
    document.dispose();

    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/$offerTitle.pdf';
    final File file = File(path);
    await file.writeAsBytes(bytes);

    return path;
  }
}
