import 'package:flutter/material.dart';

class StarRatingBar extends StatelessWidget {
  const StarRatingBar({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final star = index + 1;
        final selected = star <= rating;
        return InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => onChanged(star),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              selected ? Icons.star_rounded : Icons.star_outline_rounded,
              color: selected ? Colors.amber : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 38,
            ),
          ),
        );
      }),
    );
  }
}
