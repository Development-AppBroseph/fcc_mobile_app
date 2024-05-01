import 'package:fcc_app_front/export.dart';

class CatalogCart extends StatelessWidget {
  final CatalogModel catalog;
  final Function? function;
  const CatalogCart({
    required this.catalog,
    this.function,
    Key? key,
  }) : super(key: key);

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
          boxShadow: <BoxShadow>[
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
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    height: 90,
                    child: catalog.image != null
                        ? ClipRect(
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.r),
                                ),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: catalog.image!,
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
                    children: <Widget>[
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
