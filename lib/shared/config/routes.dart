import 'package:collection/collection.dart';
import 'package:fcc_app_front/features/auth/presentation/pages/unauthenticated_invite.dart';
import 'package:fcc_app_front/features/catalog/presentation/pages/catalog_menu_profile.dart';
import 'package:fcc_app_front/features/catalog/presentation/pages/catalog_product.dart';
import 'package:fcc_app_front/features/catalog/presentation/pages/catalog_product_profile.dart';
import 'package:fcc_app_front/features/catalog/presentation/pages/intro_catalogs.dart';
import 'package:fcc_app_front/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:fcc_app_front/features/fcc_settings/presentation/pages/fcc_data.dart';
import 'package:fcc_app_front/features/fcc_settings/presentation/pages/version.dart';
import 'package:fcc_app_front/features/menu/data/models/multiple_cubits.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/catalog_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/selected_products_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/pages/menu_products.dart';
import 'package:fcc_app_front/features/payment/presentation/pages/congratulation.dart';
import 'package:fcc_app_front/features/payment/presentation/pages/web_checkout.dart';
import 'package:fcc_app_front/features/settings/presentation/cubit/discount_cubit.dart';
import 'package:fcc_app_front/features/settings/presentation/pages/edit_profile.dart';
import 'package:fcc_app_front/features/settings/presentation/pages/not_signed.dart';
import 'package:hive/hive.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/catalog/data/datasources/catalog.dart';
import '../../features/catalog/presentation/cubit/membership_cubit.dart';
import '../../features/catalog/presentation/pages/catalog_menu.dart';
import '../../features/chat/presentation/pages/chat.dart';
import '../../features/fcc_settings/presentation/pages/fsc_settings_page.dart';
import '../../features/catalog/presentation/pages/terms_of_use_page.dart';
import '../../features/menu/presentation/cubit/product_cubit.dart';
import '../../features/menu/presentation/pages/order_confirmation.dart';
import '../../features/menu/presentation/pages/placing_order.dart';
import '../../features/menu/presentation/pages/selected_product.dart';
import '../../features/settings/presentation/pages/app_settings.dart';
import '../../features/settings/presentation/pages/change_phone_num.dart';
import '../../features/settings/presentation/pages/change_plan_page.dart';
import '../../features/notifications/presentation/pages/notification_page.dart';
import '../../features/settings/presentation/pages/offer_page.dart';
import '../../features/settings/presentation/pages/profile.dart';

import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/catalog/presentation/pages/catalog_page.dart';
import '../../features/auth/presentation/pages/cont_info_page.dart';
import '../../features/auth/presentation/pages/forgot_user_name.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/product_not_picked.dart';
import '../../features/invite/presentation/pages/invite_friend.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/menu/presentation/pages/menu.dart';
import '../../features/menu/presentation/pages/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../constants/hive.dart';
import '../widgets/error_screen.dart';

class Routes {
  static String menu = '/';
  static String productMenu = 'productMenu/:id';
  static String selectedProduct = '/selectedProduct';
  static String placeOrder = '/placeOrder';
  static String orderConfirm = '/orderConfirm';

  static String order = '/order';
  static String invite = '/invite';

  static String profile = '/profile';
  static String chat = '/chat/:id';
  static String notifications = 'notifications';
  static String addPerson = 'addPerson';
  static String changePlan = 'changePlan';
  static String notSigned = 'notSigned';
  static String changeNumber = 'changeNumber';
  static String editProfile = 'editProfile';
  static String settings = 'settings';

  static String fscSettings = 'fscSettings';
  static String fscData = '/fscData';
  static String fscProfileData = 'fscProfileData';
  static String version = 'version';

  static String termsOfUse = '/termsOfUse';

  static String login = '/login';
  static String auth = '/auth';
  static String forgot = 'forgot';
  static String contactInfo = '/contactInfo';
  static String notPicked = 'notPicked';

  static String catalog = '/catalog';
  static String introCatalog = '/introCatalog';
  static String unauthenticatedInvite = '/unauthenticatedInvite';
  static String catalogMenu = 'catalogMenu/:type';
  static String catalogProductMenu = '/catalogProductMenu/:id';
  static String catalogMenuProfile = 'ctMenuProfile/:type';
  static String catalogProductProfile = '/ctProductProfile/:id';
  static String payment = '/payment';
  static String paymentCongrats = '/paymentCongrats';
}

class RoutesNames {
  static String menu = 'menu';
  static String productMenu = 'productMenu';
  static String selectedProduct = 'selectedProduct';
  static String placeOrder = 'placeOrder';
  static String orderConfirm = 'orderConfirm';

  static String order = 'order';
  static String invite = 'invite';

  static String profile = 'profile';
  static String chat = 'chat';
  static String notifications = 'notifications';
  static String addPerson = 'addPerson';
  static String changePlan = 'changePlan';
  static String notSigned = 'notSigned';
  static String changeNumber = 'changeNumber';
  static String editProfile = 'editProfile';
  static String settings = 'settings';

  static String fscSettings = 'fscSettings';
  static String fscData = 'fscData';
  static String fscProfileData = 'fscProfileData';
  static String version = 'version';

  static String termsOfUse = 'termsOfUse';

  static String login = 'login';
  static String auth = 'auth';
  static String forgot = 'forgot';
  static String contactInfo = 'contactInfo';
  static String notPicked = 'notPicked';

  static String introCatalog = 'introCatalog';
  static String unauthenticatedInvite = 'unauthenticatedInvite';
  static String catalog = 'catalog';
  static String catalogMenu = 'catalogMenu';
  static String catalogProductMenu = 'catalogProductMenu';
  static String catalogMenuProfile = 'ctMenuProfile';
  static String catalogProductProfile = 'ctProductProfile';
  static String payment = 'payment';
  static String paymentCongrats = 'paymentCongrats';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: Routes.unauthenticatedInvite,
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error?.message ?? 'Error happened',
  ),
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainPage(
        key: state.pageKey,
        child: child,
      ),
      routes: [
        GoRoute(
            path: Routes.menu,
            name: RoutesNames.menu,
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: const Menu(),
                ),
            routes: [
              GoRoute(
                path: Routes.productMenu,
                name: RoutesNames.productMenu,
                pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: ProductMenu(
                    catalogId: state.pathParameters['id'] as String,
                  ),
                ),
              ),
            ]),
        GoRoute(
          path: Routes.profile,
          name: RoutesNames.profile,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const ProfilePage(),
          ),
          routes: [
            GoRoute(
              path: Routes.notifications,
              name: RoutesNames.notifications,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const NotificationSettingsPage(),
              ),
            ),
            GoRoute(
              path: Routes.addPerson,
              name: RoutesNames.addPerson,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: BlocProvider.value(
                  value: state.extra as DiscountCubit,
                  child: const OfferPage(),
                ),
              ),
            ),
            GoRoute(
                path: Routes.settings,
                name: RoutesNames.settings,
                pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                      context: context,
                      state: state,
                      child: const AppSettingsPage(),
                    ),
                routes: [
                  GoRoute(
                    path: Routes.changeNumber,
                    name: RoutesNames.changeNumber,
                    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                      context: context,
                      state: state,
                      child: const ChangePhoneNum(),
                    ),
                  ),
                  GoRoute(
                    path: Routes.notSigned,
                    name: RoutesNames.notSigned,
                    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                      context: context,
                      state: state,
                      child: const NotSignedPage(),
                    ),
                  ),
                  GoRoute(
                    path: Routes.editProfile,
                    name: RoutesNames.editProfile,
                    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                      context: context,
                      state: state,
                      child: const EditProfilePage(),
                    ),
                  ),
                ]),
            GoRoute(
              path: Routes.fscSettings,
              name: RoutesNames.fscSettings,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const FscSettingsPage(),
              ),
              routes: [
                GoRoute(
                  path: Routes.fscProfileData,
                  name: RoutesNames.fscProfileData,
                  pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                    context: context,
                    state: state,
                    child: FscDataPage(
                      data: state.extra as MapEntry,
                    ),
                  ),
                ),
                GoRoute(
                  path: Routes.version,
                  name: RoutesNames.version,
                  pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                    context: context,
                    state: state,
                    child: const VersionPage(),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: Routes.changePlan,
              name: RoutesNames.changePlan,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const ChangePlanPage(),
              ),
              routes: [
                GoRoute(
                  path: Routes.catalogMenuProfile,
                  name: RoutesNames.catalogMenuProfile,
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) {
                    return buildPageWithDefaultTransition<void>(
                      context: context,
                      state: state,
                      child: BlocProvider.value(
                        value: state.extra as MembershipCubit,
                        child: CatalogMenuProfile(
                          type: MembershipType.values.firstWhereOrNull(
                                (element) =>
                                    element.name ==
                                    state.pathParameters['type'] as String,
                              ) ??
                              MembershipType.standard,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Routes.invite,
          name: RoutesNames.invite,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const InviteFrPage(
              showBackButton: false,
            ),
          ),
        ),
        GoRoute(
          path: Routes.order,
          name: RoutesNames.order,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const OrderDetails(),
          ),
        ),
        GoRoute(
          path: Routes.termsOfUse,
          name: RoutesNames.termsOfUse,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const TermOfUsePage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: Routes.fscData,
      name: RoutesNames.fscData,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: FscDataPage(
          data: state.extra as MapEntry,
        ),
      ),
    ),
    GoRoute(
      path: Routes.chat,
      name: RoutesNames.chat,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: BlocProvider.value(
          value: state.extra as ChatCubit,
          child: ChatPage(
            id: state.pathParameters['id'] as String,
          ),
        ),
      ),
    ),
    GoRoute(
      path: Routes.placeOrder,
      name: RoutesNames.placeOrder,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final cubits = state.extra as MultipleCubits;
        return buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: cubits.cubits['productCubit'] as ProductCubit,
              ),
              BlocProvider.value(
                value: cubits.cubits['selectedProductsCubit'] as SelectedProductsCubit,
              ),
            ],
            child: const PlacingOrderPage(),
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.orderConfirm,
      name: RoutesNames.orderConfirm,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const OrderConfirmationPage(),
      ),
    ),
    GoRoute(
        path: Routes.selectedProduct,
        name: RoutesNames.selectedProduct,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final cubits = state.extra as MultipleCubits;
          return buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: cubits.cubits['productCubit'] as ProductCubit,
                ),
                BlocProvider.value(
                  value: cubits.cubits['selectedProductsCubit'] as SelectedProductsCubit,
                ),
              ],
              child: const SelectedProductPage(),
            ),
          );
        }),
    GoRoute(
      path: Routes.login,
      name: RoutesNames.login,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: Routes.introCatalog,
      name: RoutesNames.introCatalog,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const IntroCatalogPage(),
      ),
    ),
    GoRoute(
      path: Routes.unauthenticatedInvite,
      name: RoutesNames.unauthenticatedInvite,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const UnauthenticatedInvitePage(),
      ),
    ),
    GoRoute(
      path: Routes.auth,
      name: RoutesNames.auth,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: AuthPage(
          phone: state.extra as String,
        ),
      ),
      routes: [
        GoRoute(
          path: Routes.forgot,
          name: RoutesNames.forgot,
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const ForgotUserName(),
          ),
        ),
        GoRoute(
          path: Routes.notPicked,
          name: RoutesNames.notPicked,
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const ProductNotPicked(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: Routes.contactInfo,
      name: RoutesNames.contactInfo,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: ContInfoPage(phone: state.extra as String),
      ),
    ),
    GoRoute(
      path: Routes.catalog,
      name: RoutesNames.catalog,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: CatalogPage(
          phone: state.extra as String,
        ),
      ),
      routes: [
        GoRoute(
          path: Routes.catalogMenu,
          name: RoutesNames.catalogMenu,
          parentNavigatorKey: _rootNavigatorKey,
          pageBuilder: (context, state) {
            return buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: BlocProvider.value(
                value: state.extra as MembershipCubit,
                child: CatalogMenu(
                  type: MembershipType.values.firstWhereOrNull(
                        (element) =>
                            element.name == state.pathParameters['type'] as String,
                      ) ??
                      MembershipType.standard,
                ),
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: Routes.payment,
      name: RoutesNames.payment,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final url = data['paymentUrl'] as String;
        final phone = data['phone'] as String;
        final onComplete = data['onComplete'] as Function;
        return buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: WebCheckoutPage(
            url: url,
            phone: phone,
            onComplete: onComplete,
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.paymentCongrats,
      name: RoutesNames.paymentCongrats,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final membership = data['membership'] as String;
        final goMenu = data['goMenu'] as bool;
        return buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: PaymentCongratulationPage(
            membership: membership,
            goMenu: goMenu,
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.catalogProductProfile,
      name: RoutesNames.catalogProductProfile,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final cubits = state.extra as MultipleCubits;
        return buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: cubits.cubits['productCubit'] as ProductCubit,
              ),
              BlocProvider.value(
                value: cubits.cubits['catalogCubit'] as CatalogCubit,
              ),
            ],
            child: CatalogProductProfileMenu(
              catalogId: state.pathParameters['id'] as String,
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.catalogProductMenu,
      name: RoutesNames.catalogProductMenu,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final cubits = state.extra as MultipleCubits;
        return buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: cubits.cubits['productCubit'] as ProductCubit,
              ),
              BlocProvider.value(
                value: cubits.cubits['catalogCubit'] as CatalogCubit,
              ),
            ],
            child: CatalogProductMenu(
              catalogId: state.pathParameters['id'] as String,
            ),
          ),
        );
      },
    ),
  ],
  redirect: (BuildContext buildContext, GoRouterState state) {
    if (Hive.box(HiveStrings.userBox).containsKey(HiveStrings.invite) &&
        state.fullPath!.contains(Routes.unauthenticatedInvite)) {
      return Routes.introCatalog;
    }
    if ((state.fullPath!.contains(Routes.unauthenticatedInvite) ||
            state.fullPath!.contains(Routes.introCatalog)) &&
        buildContext.read<AuthCubit>().state is Authenticated) {
      return Routes.menu;
    }
    return null;
  },
);

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
