import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_walls/getx.dart';

Widget customButton(MyController controller, String title) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: controller.downloadingDone.value
          ? const LinearGradient(colors: [Colors.yellow, Colors.black])
          : const LinearGradient(colors: [Colors.grey, Colors.grey]),
    ),
    child: SizedBox(
      height: 30,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
