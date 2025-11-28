import 'package:flutter/material.dart';

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isCompact;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isCompact,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Renkler
    final primaryColor = Theme.of(context).colorScheme.primary;
    final hoverIconColor = const Color(0xFF10B981); // 🟢 Canlı yeşil (ikon için)
    final hoverTextColor = Colors.white; // ⚪ Beyaz (yazı için)
    final selectedIconColor = const Color(0xFFFF9900); // 🟠 Seçim ikon rengi
    final selectedTextColor = const Color.fromARGB(255, 226, 225, 225); // ⚪ Seçim yazı rengi
    final defaultColor = Colors.grey.shade600;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? primaryColor.withValues(alpha: 0.12) // Seçili arka plan
                : (isHovered
                    ? primaryColor.withValues(alpha: 0.08) // Hover arka plan (isteğe bağlı)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.isSelected
                    ? selectedIconColor // 🟠 Seçim ikon rengi
                    : isHovered
                        ? hoverIconColor // 🟢 Hover ikon rengi
                        : defaultColor, // ⚫ Normal renk
              ),
              if (!widget.isCompact) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: widget.isSelected
                          ? selectedTextColor // ⚪ Seçim yazı rengi
                          : isHovered
                              ? hoverTextColor // ⚪ Hover yazı rengi
                              : defaultColor, // ⚫ Normal renk
                      fontWeight: widget.isSelected ? FontWeight.normal : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}