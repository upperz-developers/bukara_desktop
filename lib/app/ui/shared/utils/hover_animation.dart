import 'package:flutter/material.dart';

class OnHoverEffect extends StatefulWidget {
  final Widget child;
  const OnHoverEffect({Key? key, required this.child}) : super(key: key);

  @override
  State<OnHoverEffect> createState() => _OnHoverEffectState();
}

class _OnHoverEffectState extends State<OnHoverEffect> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.01);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      onEnter: ((event) => onEntered(true)),
      onExit: ((event) => onEntered(false)),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        transform: transform,
        child: widget.child,
      ),
    );
  }

  onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
