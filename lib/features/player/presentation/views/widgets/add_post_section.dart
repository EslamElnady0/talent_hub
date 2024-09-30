import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/routes/app_router.dart';

Widget addPostSection(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: GestureDetector(
      onTap: () {
        context.pushNamed(AppRouter.post);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Text(
          "Share Your Talent From Here",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    ),
  );
}
