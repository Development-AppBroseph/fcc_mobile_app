import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/presentation/bloc/membersheep_bloc.dart';

class CatalogProductDetails extends StatelessWidget {
  final ProductModel? model;
  const CatalogProductDetails({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CustomBackButton(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height / 2.5,
                  width: size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: model?.image ?? '',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  model?.name ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  model?.description ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProductTextDetailsField(
                  title: 'Марка',
                  subtitle: model?.name ?? '',
                ),
                ProductTextDetailsField(
                  title: 'Страна происхождения',
                  subtitle: model?.country ?? '',
                ),
                const ProductTextDetailsField(
                  title: 'Количество блоков',
                  subtitle: '4',
                ),
                ProductTextDetailsField(
                  title: 'Крепость',
                  subtitle: model?.strenght ?? '',
                ),
                ProductTextDetailsField(
                  title: 'Вкус',
                  subtitle: model?.taste ?? '',
                ),
                ProductTextDetailsField(
                  title: 'Формат',
                  subtitle: model?.format ?? '',
                ),
                const SizedBox(
                  height: 40,
                ),
                CstmBtn(
                    text: 'Оформить заказ',
                    onTap: () async {
                      context.go(Routes.introCatalog);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
