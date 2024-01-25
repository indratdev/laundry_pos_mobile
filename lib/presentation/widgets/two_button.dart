import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';

class TwoButton extends StatelessWidget {
  final void Function() mainButtonvoidCallback;
  final String mainTitleButton;
  final void Function()? secondButtonvoidCallback;
  final String secondTitleButton;
  final bool isVisibleSecondButton;
  final double widthMainDefault;
  final double widthSecondDefault;
  final double heightDefault;
  final Icon? iconSecondButton;

  const TwoButton({
    super.key,
    this.mainTitleButton = "PROSES",
    required this.mainButtonvoidCallback,
    this.secondTitleButton = "BATAL",
    this.secondButtonvoidCallback,
    this.widthMainDefault = 3,
    this.widthSecondDefault = 3,
    this.heightDefault = 17,
    this.isVisibleSecondButton = true,
    this.iconSecondButton,
  });

  // final ButtonStatusWidget widget;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height / heightDefault;

    return Row(
      mainAxisAlignment: (isVisibleSecondButton)
          ? MainAxisAlignment.spaceAround
          : MainAxisAlignment.center,
      children: [
        (isVisibleSecondButton)
            ? SizedBox(
                width: width / widthSecondDefault,
                height: height,
                child: ElevatedButton.icon(
                  icon: (iconSecondButton != null)
                      ? iconSecondButton!
                      : const SizedBox(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white.withOpacity(0.9),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (secondButtonvoidCallback == null)
                      ? () => Navigator.pop(context)
                      : secondButtonvoidCallback,
                  label: Text(
                    secondTitleButton,
                    style: const TextStyle(),
                  ),
                ),
              )
            : const SizedBox(),
        SizedBox(
          width:
              (isVisibleSecondButton) ? width / widthMainDefault : width - 100,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              backgroundColor: AppColors.hardBlueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: mainButtonvoidCallback,
            child: Text(mainTitleButton,
                style: const TextStyle(color: AppColors.white)),
          ),
        ),
      ],
    );
  }
}
