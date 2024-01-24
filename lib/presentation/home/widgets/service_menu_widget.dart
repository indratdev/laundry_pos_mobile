import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class ServiceMenuWidget extends StatelessWidget {
  final String title;
  final String iconName;
  final Function()? onTap;

  const ServiceMenuWidget({
    super.key,
    required this.title,
    required this.iconName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.disabled.withOpacity(.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 8,
              child: Image.asset(
                iconName,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: MediaQuery.of(context).size.width / 18,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
