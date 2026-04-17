import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const CardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),

        // Glow effect (futuristic feel)
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 1,
          )
        ],
      ),
      child: child,
    );
  }
}