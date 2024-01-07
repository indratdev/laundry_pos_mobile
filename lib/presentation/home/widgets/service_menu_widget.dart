import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/core/extensions/build_context_ext.dart';

import '../../../core/constants/colors.dart';

class ServiceMenuWidget extends StatelessWidget {
  String title;
  String iconName;

  ServiceMenuWidget({
    super.key,
    required this.title,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              margin: EdgeInsets.only(top: 8),
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
