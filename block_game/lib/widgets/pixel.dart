import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final Color? color;
  const Pixel({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(0.1),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(0),
        image: color == null // Sirf empty blocks pe image dikhani hai
            ? DecorationImage(
                image: AssetImage('assets/images/wooden_texture_block.jpg'),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}
