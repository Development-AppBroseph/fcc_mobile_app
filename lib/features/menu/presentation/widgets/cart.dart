
import 'package:fcc_app_front/export.dart';

class ProductCart extends StatelessWidget {
  final Product? product;
  final bool isSelected;
  final bool canSelect;

  const ProductCart({
    required this.product,
    this.isSelected = false,
    this.canSelect = true,
    super.key,
  });

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
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.1),
              blurRadius: 46,
            )
          ],
          border: Border.all(
            color: isSelected
                ? primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (
                  BuildContext context,
                ) {
                  return ProductDetails(model: product);
                }));
              },
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 90,
                    child: CachedNetworkImage(
                      imageUrl: product?.image ?? '',
                      imageBuilder: (
                        BuildContext context,
                        ImageProvider<Object> imageProvider,
                      ) {
                        return AspectRatio(
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
                        );
                      },
                      placeholder: (BuildContext context, String url) =>
                          AspectRatio(
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
                      errorWidget: (
                        BuildContext context,
                        String url,
                        Object error,
                      ) {
                        return AspectRatio(
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
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          product?.name ?? '',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        sized5,
                        Text(
                          product?.description ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        sized5,
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
