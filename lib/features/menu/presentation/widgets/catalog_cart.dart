import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcc_app_front/features/menu/data/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/colors/color.dart';

class CatalogCart extends StatelessWidget {
  const CatalogCart({
    Key? key,
    required this.catalog,
    this.function,
  }) : super(key: key);
  final CatalogModel catalog;
  final Function? function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (function != null) function!();
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
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    height: 90,
                    child: catalog.image != null
                        ? CachedNetworkImage(
                            imageUrl: catalog.image!,
                            imageBuilder: (context, imageProvider) =>
                                AspectRatio(
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
                          )
                        : AspectRatio(
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
                    children: [
                      Text(
                        catalog.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        catalog.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 12.5,
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
