import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  final void Function()? onTap;
  const MyPostButton({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
        child: const Center(child: Icon(Icons.done)),
      ),
    );
  }
}
