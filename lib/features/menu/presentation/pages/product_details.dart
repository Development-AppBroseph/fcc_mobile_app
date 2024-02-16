import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/data/models/membership.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel model;
  const ProductDetails({
    required this.model,
    super.key,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
                          imageUrl:
                              'https://media.sketchfab.com/models/4eb251a5b2874b3ea329da82db428a5d/thumbnails/823c12b6ae604825b82ed6cca2885b06/73cb7ce63b48404e883fa748cb11d9ad.jpeg')),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.model.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.model.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProductTextDetailsField(
                  title: 'Марка',
                  subtitle: widget.model.name,
                ),
                ProductTextDetailsField(
                  title: 'Страна произхождение',
                  subtitle: widget.model.id.toString(),
                ),
                ProductTextDetailsField(
                  title: 'Количесевтво блоков',
                  subtitle: widget.model.stock.toString(),
                ),
                const ProductTextDetailsField(
                  title: 'Крескость',
                  subtitle: 'Крепкость',
                ),
                const ProductTextDetailsField(
                  title: 'Вкус',
                  subtitle: 'Вкус',
                ),
                const ProductTextDetailsField(
                  title: 'Формат',
                  subtitle: 'Формат',
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    return CstmBtn(
                      text: 'Оформить заказ',
                      onTap: () async {
                        final CurrentMembership? merbership = await context
                            .read<AuthCubit>()
                            .getCurrentMerbership();
                        if (state is Authenticated) {
                          //TODO: add logic
                          if (merbership?.membership?.level == null &&
                              context.mounted) {
                            ApplicationSnackBar.showErrorSnackBar(
                              context,
                              'Выберите план',
                              1,
                              const EdgeInsets.all(10),
                              10,
                            );
                          }
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
