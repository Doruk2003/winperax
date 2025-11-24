import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/teklif/presentation/pages/yeni_teklif_page.dart';

class TeklifListesiPage extends StatefulWidget {
  const TeklifListesiPage({super.key});

  @override
  State<TeklifListesiPage> createState() => _TeklifListesiPageState();
}

class _TeklifListesiPageState extends State<TeklifListesiPage> {
  bool showMobileFilters = false;

  // ───────────────────────────────
  // UI Helper Methods (Login ekranıyla birebir aynı stil)
  // ───────────────────────────────

  InputDecoration _buildInputDecoration({
    required String labelText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _focusedBorder(),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.green.shade400, width: 2),
    );
  }

  ElevatedButton _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
    bool loading = false,
  }) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF66BB6A),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(double.infinity, 48),
      ),
      child: loading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(text, style: const TextStyle(fontFamily: 'Montserrat')),
    );
  }

  ElevatedButton _buildSecondaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(0, 48),
      ),
      child: Text(text, style: const TextStyle(fontFamily: 'Montserrat')),
    );
  }

  // ───────────────────────────────
  // BUILD
  // ───────────────────────────────

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget _buildHeader() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TEKLİF',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => const YeniTeklifPage());
              },
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF66BB6A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      );
    }

    if (width < 600) {
      return Scaffold(
        body: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMobile()),
          ],
        ),
      );
    } else if (width < 1024) {
      return Scaffold(
        body: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildTablet()),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildWeb()),
          ],
        ),
      );
    }
  }

  // ───────────────────────────────
  // MOBILE
  // ───────────────────────────────

  Widget _buildMobile() {
    return Column(
      children: [
        _buildMobileFilterButton(),
        if (showMobileFilters) _buildMobileFilters(),
        Expanded(child: _buildMobileList()),
      ],
    );
  }

  Widget _buildMobileFilterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _buildPrimaryButton(
        text: "Filtreleri Göster",
        onPressed: () {
          setState(() => showMobileFilters = !showMobileFilters);
        },
      ),
    );
  }

  Widget _buildMobileFilters() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(decoration: _buildInputDecoration(labelText: "Cari Ara")),
          const SizedBox(height: 8),
          TextField(
            decoration: _buildInputDecoration(labelText: "Müşteri Ara"),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: _buildInputDecoration(labelText: "Teklif No Ara"),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSecondaryButton(text: "Temizle", onPressed: () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildPrimaryButton(text: "Uygula", onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        final isEven = index % 2 == 0;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isEven ? Colors.white : Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "WIN-000001",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue[800],
                      ),
                    ),
                    Chip(
                      label: const Text("Aktif"),
                      backgroundColor: Colors.green[100],
                      labelStyle: TextStyle(color: Colors.green[800]),
                    ),
                  ],
                ),
                const Divider(height: 20, thickness: 1),
                const Text("Cari: ABC Ltd.", style: TextStyle(fontSize: 14)),
                const Text(
                  "Müşteri: Mehmet Yılmaz",
                  style: TextStyle(fontSize: 14),
                ),
                const Text("Tarih: 21.11.2025", style: TextStyle(fontSize: 14)),
                const Text("Alan: 12.4 m²", style: TextStyle(fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye),
                      color: Colors.blue,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ───────────────────────────────
  // TABLET
  // ───────────────────────────────

  Widget _buildTablet() {
    return Column(
      children: [
        _buildTabletFilters(),
        Expanded(child: _buildTabletList()),
      ],
    );
  }

  Widget _buildTabletFilters() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              decoration: _buildInputDecoration(labelText: "Cari Ara"),
            ),
          ),
          SizedBox(
            width: 250,
            child: TextField(
              decoration: _buildInputDecoration(labelText: "Müşteri Ara"),
            ),
          ),
          SizedBox(
            width: 250,
            child: TextField(
              decoration: _buildInputDecoration(labelText: "Teklif No Ara"),
            ),
          ),
          SizedBox(
            width: 180,
            child: _buildPrimaryButton(text: "Filtre Uygula", onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        final isEven = index % 2 == 0;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isEven ? Colors.white : Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "WIN-000001",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                Expanded(flex: 2, child: const Text("ABC Ltd.")),
                Expanded(flex: 2, child: const Text("Mehmet Yılmaz")),
                Expanded(flex: 2, child: const Text("21.11.2025")),
                Expanded(flex: 1, child: const Text("12.4")),
                Expanded(
                  flex: 1,
                  child: Chip(
                    label: const Text("Aktif"),
                    backgroundColor: Colors.green[100],
                    labelStyle: TextStyle(color: Colors.green[800]),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ───────────────────────────────
  // WEB
  // ───────────────────────────────

  Widget _buildWeb() {
    return Column(
      children: [
        _buildWebFilters(),
        Expanded(child: _buildWebList()),
      ],
    );
  }

  Widget _buildWebFilters() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: _buildInputDecoration(labelText: "Cari Ara"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: _buildInputDecoration(labelText: "Müşteri Ara"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: _buildInputDecoration(labelText: "Teklif No Ara"),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 180,
            child: _buildPrimaryButton(text: "Filtre Uygula", onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildWebList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        final isEven = index % 2 == 0;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isEven ? Colors.white : Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "WIN-000001",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                Expanded(flex: 2, child: const Text("ABC Ltd.")),
                Expanded(flex: 2, child: const Text("Mehmet Yılmaz")),
                Expanded(flex: 2, child: const Text("21.11.2025")),
                Expanded(flex: 1, child: const Text("12.4")),
                Expanded(
                  flex: 1,
                  child: Chip(
                    label: const Text("Aktif"),
                    backgroundColor: Colors.green[100],
                    labelStyle: TextStyle(color: Colors.green[800]),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
