import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/presentation/widgets/two_button.dart';

enum StatusImage {
  success,
  failed,
  warning,
}

class CustomDialogs {
  String getStatusImage(StatusImage statusImage) {
    String name = "";

    if (statusImage.name == StatusImage.success.name) {
      name = Variables.doneIcon;
    }

    return name;
  }

  // static showLoadingWidget() {
  //   return const Center(child: Text('Loading..'));
  // }

  // static showInfoMessageWidget(String message) {
  //   return Center(child: Text(message));
  // }

  // loading widget
  // static showLoadingWidget(
  //   BuildContext context,
  // ) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 120),
  //           child: Dialog(
  //             insetPadding: EdgeInsets.zero,
  //             clipBehavior: Clip.antiAliasWithSaveLayer,

  //             elevation: 1,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8.0)), //this right here
  //             child: Container(
  //               height: MediaQuery.of(context).size.height / 8,
  //               width: MediaQuery.of(context).size.width / 4,
  //               child: const Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   CircularProgressIndicator.adaptive(),
  //                   SizedBox(height: 15),
  //                   Text('Loading...'),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  static showConfirmation(
      BuildContext context, String content, void Function()? voidCallback) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      foregroundColor: Colors.transparent,
                      child: Image.asset(Variables.warningIcon),
                    ),
                    const SizedBox(height: 12),
                    Text(content, textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    TwoButton(
                      heightDefault: 20,
                      widthSecondDefault: 4,
                      widthMainDefault: 3,
                      mainButtonvoidCallback: voidCallback!,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // void showMessageAlert(
  //   BuildContext context,
  //   String content,
  //   StatusImage statusImage,
  //   Function()? voidCallBack,
  // ) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext dialogContext) {
  //       // Capture the context before entering async operation
  //       final capturedContext = dialogContext;

  //       return Dialog(
  //         backgroundColor: CustomColor.backgroundColor,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: SizedBox(
  //           height: MediaQuery.of(capturedContext).size.height / 3,
  //           width: MediaQuery.of(capturedContext).size.width / 3,
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Flexible(
  //                   flex: 4,
  //                   child: SizedBox(
  //                     width: double.infinity,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         CircleAvatar(
  //                           radius:
  //                               MediaQuery.of(capturedContext).size.width / 8,
  //                           foregroundColor: Colors.transparent,
  //                           child: Image.asset(
  //                             getStatusImage(statusImage),
  //                             fit: BoxFit.fill,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 10),
  //                         Text(
  //                           content,
  //                           textAlign: TextAlign.center,
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Flexible(
  //                   flex: 1,
  //                   child: SizedBox(
  //                     width: MediaQuery.of(capturedContext).size.width / 2.5,
  //                     child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         elevation: 1,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                       ),
  //                       onPressed: (voidCallBack == null)
  //                           ? () => Navigator.pop(capturedContext)
  //                           : voidCallBack,
  //                       child: const Text("OK"),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // old version
  showMessageAlert(
    BuildContext context,
    String content,
    StatusImage statusImage,
    Function()? voidCallBack,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 8,
                              foregroundColor: Colors.transparent,
                              child: Image.asset(
                                getStatusImage(statusImage),
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              content,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            backgroundColor: AppColors.middleBlueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          // onPressed: () => Navigator.pop(context),
                          onPressed: (voidCallBack == null)
                              ? () => Navigator.pop(context)
                              : voidCallBack,
                          child: const Text(
                            "OK",
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // static showPaymentOption(BuildContext context) {
  //   return showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.money),
  //               title: Text('Tunai'),
  //               onTap: () {
  //                 Navigator.pop(context, {"Tunai": "cash"});
  //               },
  //             ),
  //             // ListTile(
  //             //   leading: new Icon(Icons.music_note),
  //             //   title: new Text('Music'),
  //             //   onTap: () {
  //             //     Navigator.pop(context);
  //             //   },
  //             // ),
  //             // ListTile(
  //             //   leading: new Icon(Icons.videocam),
  //             //   title: new Text('Video'),
  //             //   onTap: () {
  //             //     Navigator.pop(context);
  //             //   },
  //             // ),
  //             // ListTile(
  //             //   leading: new Icon(Icons.share),
  //             //   title: new Text('Share'),
  //             //   onTap: () {
  //             //     Navigator.pop(context);
  //             //   },
  //             // ),
  //           ],
  //         );
  //       });
  // }

  static Future<Map<String, dynamic>> showPaymentOption(
      BuildContext context) async {
    return await showModalBottomSheet<Map<String, dynamic>>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
          ),
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: .2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.money),
                      title: Text('Tunai'),
                      onTap: () {
                        Navigator.pop(context, {"Tunai": "cash"});
                      },
                    ),
                  ),
                  // Add more payment options here.
                ],
              ),
            );
          },
        ) ??
        {}; // Provide an empty Map as a default value in case no option is selected.
  }

  // showModalBottomSheetTakeSource(
  //   BuildContext context,
  // ) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.camera_alt),
  //               title: Text('Kamera'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.image_rounded),
  //               title: Text('Galeri Foto'),
  //               onTap: () {
  //                 // Navigator.pop(context);
  //                 // getImageFromGallery();
  //                 ImageManager().getImageFromGallery();
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  // static showMessageAlertWithF(
  //   BuildContext context,
  //   String content,
  //   bool isSuccess,
  //   Function()? voidCallBack,
  // ) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0)), //this right here
  //           child: SizedBox(
  //             height: MediaQuery.of(context).size.height / 3,
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   CircleAvatar(
  //                     radius: MediaQuery.of(context).size.width / 8,
  //                     foregroundColor: Colors.transparent,
  //                     child: ClipOval(
  //                       child: Image.asset(
  //                         (isSuccess) ? successImage : failedImage,
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                   ),
  //                   sbHeight20,
  //                   Text(content, textAlign: TextAlign.center),
  //                   sbHeight20,
  //                   SizedBox(
  //                     width: MediaQuery.of(context).size.width / 2,
  //                     child: ElevatedButton(
  //                       onPressed: voidCallBack,
  //                       child: const Text("OK"),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  // static showModalPaymentWidget(BuildContext context, OrdersModel? orders,
  //     double totalTranscationAmount) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     context: context,
  //     builder: (context) {
  //       return Wrap(
  //         children: [
  //           ListTile(
  //               leading: const Icon(Icons.wallet_outlined),
  //               title: const Text('Tunai / Cash'),
  //               subtitle: const Text("Menggunakan uang tunai"),
  //               trailing: const Icon(Icons.arrow_forward_ios),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => CashPaymentTransactionScreen(
  //                           orderCustomer: orders,
  //                           totalTranscationAmount: totalTranscationAmount),
  //                     ));
  //               }),
  //           const ListTile(
  //             leading: Icon(Icons.wallet_outlined),
  //             title: Text('Kartu Debit'),
  //             subtitle: Text("Menggunakan kartu debit"),
  //             trailing: Icon(Icons.arrow_forward_ios),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // static showSnackBarCustom(BuildContext context, String message) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 2),
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }
}
