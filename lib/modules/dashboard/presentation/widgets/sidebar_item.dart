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
    final hoverIconColor = AppColors.primaryColor; // Orta gri
    final selectedIconColor = AppColors.primaryColor; // Mor
    final defaultColor = AppColors.iconColorLight; // Orta gri

    // ✅ Tooltip için: Sadece compact modda ve hover durumunda göster
    Widget itemWidget = GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? (brightness == Brightness.dark
                    ? primaryColor.withValues(alpha: 0.12)
                    : AppColors.sidebarSelectedLight)
              : (isHovered
                    ? (brightness == Brightness.dark
                          ? primaryColor.withValues(alpha: 0.08)
                          : AppColors.sidebarHoverLight)
                    : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? selectedIconColor
                  : isHovered
                      ? hoverIconColor
                      : defaultColor,
            ),
            if (!widget.isCompact) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: widget.isSelected
                        ? primaryColor
                        : isHovered
                            ? primaryColor
                            : AppColors.iconColorLight,
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
    );

    // 👇 Compact modda ve hover'daysa tooltip göster
    if (widget.isCompact && isHovered) {
      return Tooltip(
        message: widget.label, // ✅ Tooltip metni: Menü etiketi
        preferBelow: false,
        waitDuration: Duration.zero, // Hemen göster
        showDuration: const Duration(seconds: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? AppColors.tooltipDark
              : AppColors.tooltipLight, // Tema uyumlu arka plan
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: brightness == Brightness.dark
                ? AppColors.borderDark
                : AppColors.borderLight,
            width: 0.5,
          ),
        ),
        textStyle: TextStyle(
          fontSize: 12,
          color: brightness == Brightness.dark
              ? Colors.white
              : AppColors.textColorLight,
          fontWeight: FontWeight.w500,
        ),
        child: itemWidget,
      );
    }

    // Normalde MouseRegion ile hover kontrolü
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: itemWidget,
    );
  }
}