import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/menu/data/models/multiple_cubits.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:fcc_app_front/features/menu/presentation/cubit/selected_products_cubit.dart';

import '../../../../shared/config/routes.dart';
import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../../shared/widgets/snackbar.dart';
import '../widgets/cart.dart';

class SelectedProductPage extends StatelessWidget {
  const SelectedProductPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final product = context.read<SelectedProductsCubit>().state.product;
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
            children: [
              CustomBackButton(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductCart(
                      product: product,
                      isSelected: true,
                      canSelect: false,
                    ),
                    sized40,
                    CstmBtn(
                      width: double.infinity,
                      onTap: () {
                        final userState = context.read<AuthCubit>().state;
                        if (userState is Authenticated &&
                            userState.user.userName == '') {
                          ErrorSnackBar.showErrorSnackBar(
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
                              cubits: {
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
                      text: "Подтвердить",
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
