import 'package:flutter/material.dart';
import 'package:winperax/app/core/theme/colors.dart';

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
    // Tema rengine göre hover ve selected metin renkleri
    final brightness = Theme.of(context).brightness;
    final hoverTextColor = brightness == Brightness.dark
        ? Colors.white
        : AppColors.textColorLight;
    final selectedTextColor = brightness == Brightness.dark
        ? Colors.white
        : AppColors.textColorLight;

    // Diğer renkler
    final primaryColor = Theme.of(context).colorScheme.primary;
    final hoverIconColor = AppColors.primaryColor; // ✅ Orta gri
    final selectedIconColor = AppColors.primaryColor; // ✅ Mor
    final defaultColor = AppColors.iconColorLight; // ✅ Orta gri

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
                ? (brightness == Brightness.dark
                      ? primaryColor.withValues(alpha: 0.12)
                      : AppColors
                            .sidebarSelectedLight) // ✅ Light tema için açık gri
                : (isHovered
                      ? (brightness == Brightness.dark
                            ? primaryColor.withValues(alpha: 0.08)
                            : AppColors
                                  .sidebarHoverLight) // ✅ Light tema için hover
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.isSelected
                    ? selectedIconColor // ✅ Seçim ikon rengi: Mor
                    : isHovered
                    ? hoverIconColor // ✅ Hover ikon rengi: Orta gri
                    : defaultColor, // ✅ Normal ikon rengi: Orta gri
              ),
              if (!widget.isCompact) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: widget.isSelected
                          ? primaryColor // ✅ Seçim yazı rengi: Koyu gri
                          : isHovered
                          ? primaryColor // ✅ Hover yazı rengi: Koyu gri
                          : AppColors
                                .iconColorLight, // ✅ Normal yazı rengi: Orta gri
                      fontWeight: widget.isSelected
                          ? FontWeight.normal
                          : FontWeight.normal,
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
