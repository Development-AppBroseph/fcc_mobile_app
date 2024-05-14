import 'package:fcc_app_front/export.dart';

class SelectedProductPage extends StatelessWidget {
  const SelectedProductPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final Product? product =
        context.read<SelectedProductsCubit>().state.product;
    if (product == null) return Container();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomBackButton(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ProductCart(
                      product: product,
                      isSelected: true,
                      canSelect: false,
                    ),
                    sized40,
                    CstmBtn(
                      width: double.infinity,
                      onTap: () {
                        final AuthState userState =
                            context.read<AuthCubit>().state;
                        if (userState is Authenticated &&
                            userState.user.membershipLevel == '') {
                          ApplicationSnackBar.showErrorSnackBar(
                            context,
                            'Вы не ввели свои данные',
                            0.9,
                            const EdgeInsets.symmetric(horizontal: 15),
                            3,
                          );
                        } else {
                          context.pushNamed(
                            RoutesNames.placeOrder,
                            extra: MultipleCubits(
                              cubits: <String, Cubit<Equatable>>{
                                'productCubit':
                                    BlocProvider.of<ProductCubit>(context),
                                'selectedProductsCubit':
                                    BlocProvider.of<SelectedProductsCubit>(
                                        context),
                              },
                            ),
                          );
                        }
                      },
                      text: 'Подтвердить',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
