import 'package:fcc_app_front/export.dart';

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
    extra: <String, Object>{
      'membership': type.name,
      'goMenu': false,
    },
  );
}
