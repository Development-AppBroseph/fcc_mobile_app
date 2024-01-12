import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/selected_products_cubit.dart';
import 'package:fcc_app_front/shared/constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

import 'package:fcc_app_front/features/menu/data/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/colors/color.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({
    Key? key,
    required this.product,
    this.isSelected = false,
    this.canSelect = true,
  }) : super(key: key);
  final ProductModel product;
  final bool isSelected;
  final bool canSelect;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (canSelect) {
          context.read<SelectedProductsCubit>().addProduct(product);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.1),
              blurRadius: 46,
            )
          ],
          border: Border.all(
            color: isSelected ? primaryColor : Theme.of(context).scaffoldBackgroundColor,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 90,
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    imageBuilder: (context, imageProvider) => AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          color: primaryColorLight,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.smoking_rooms,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          color: primaryColorLight,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.smoking_rooms,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      sized5,
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      sized5,
                      Text(
                        '${product.price} \u20BD',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                      ),
                      Text(
                        'Доступно: ${product.stock}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
