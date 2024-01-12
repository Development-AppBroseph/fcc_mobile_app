import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/config/routes.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../menu/presentation/cubit/catalog_cubit.dart';
import '../../../menu/presentation/cubit/product_cubit.dart';

changePlan(BuildContext context, MembershipType type) async {
  context.read<ProductCubit>().load(
        isPublic: context.read<AuthCubit>().state is Unauthenticated,
      );
  context.read<CatalogCubit>().load(
        isPublic: context.read<AuthCubit>().state is Unauthenticated,
      );
  context.pop();
  context.pushNamed(
    RoutesNames.paymentCongrats,
    extra: {
      'membership': type.name,
      'goMenu': false,
    },
  );
}
