import 'package:fcc_app_front/export.dart';

void showConfirmDeleteDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) => Dialog(
      alignment: Alignment.center,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 25.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: scaffoldBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 50.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Удалить аккаунт ?',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            sized10,
            Text(
              'Ваша учетная запись будет удалена через 6 месяцев. В течение этого времени вы можете восстановить свою учетную запись, обратившись в службу поддержки клиентов.Обратите внимание, что в течение 6 месяцев ваше устройство будет привязано к вашей текущей учетной записи, и вы не сможете создать новую.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                  ),
              textAlign: TextAlign.center,
            ),
            sized20,
            CstmBtn(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 30,
              ),
              onTap: () async {
                final Future<bool> result = context.read<AuthCubit>().archiveAccount();
                if (await result) {
                  if (context.mounted) {
                    canPopThenPop(context);
                  }
                }
                // context.go(RoutesNames.unauthenticatedInvite);
              },
              text: 'Удалить аккаунт',
              color: Theme.of(context).hintColor.withOpacity(0.1),
            ),
            sized10,
            CstmBtn(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              onTap: () {
                canPopThenPop(context);
              },
              text: 'Назад',
            ),
          ],
        ),
      ),
    ),
  );
}
