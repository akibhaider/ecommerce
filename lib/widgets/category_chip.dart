import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                  )
                : null,
            color: isSelected
                ? null
                : isDark
                    ? const Color(0xFF252540)
                    : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFE5E7EB),
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : isDark
                      ? const Color(0xFFF3F4F6)
                      : const Color(0xFF1A1A2E),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
