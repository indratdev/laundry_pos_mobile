import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/core/componets/buttons.dart';
import 'package:laundry_app/core/componets/spaces.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';

class MenuProductItem extends StatelessWidget {
  final Product data;
  const MenuProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width / 5;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side:  BorderSide(width: 3, color: AppColors.black.withOpacity(.2)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: '${Variables.imageBaseUrl}${data.image}',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>  Icon(
                Icons.image_not_supported_outlined,
                size: width,
              ),
              width: width,
            ),
          ),
          const SpaceWidth(15.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SpaceHeight(5.0),
                Text(
                  data.category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SpaceHeight(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Button.outlined(
                        onPressed: () {
                          showDialog(
                              context: context,
                              // backgroundColor: AppColors.white,
                              builder: (context) {
                                //container for product detail
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  content: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data.name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.close),
                                            ),
                                          ],
                                        ),
                                        const SpaceHeight(10.0),
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${Variables.imageBaseUrl}${data.image}',
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                     Icon(
                                              Icons.food_bank_outlined,
                                              size: width,
                                            ),
                                            width: width,
                                          ),
                                        ),
                                        const SpaceHeight(10.0),
                                        Text(
                                          data.category,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SpaceHeight(5),
                                        Text(
                                          data.price.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SpaceHeight(10.0),
                                        Text(
                                          data.working_time.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SpaceHeight(10.0),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        label: 'Detail',
                        fontSize: 8.0,
                        height: 31,
                      ),
                    ),
                    const SpaceWidth(6.0),
                    Flexible(
                      // flex: 1,
                      child: Button.outlined(
                        onPressed: () {
                          // context.push(EditProductPage(data: data));
                        },
                        label: 'Ubah Produk',
                        fontSize: 8.0,
                        height: 31,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
