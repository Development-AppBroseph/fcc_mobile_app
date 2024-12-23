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
              'Вы уверены, что хотите удалить свой аккаунт? Пожалуйста, обратите внимание, что это действие нельзя будет отменить. После удаления аккаунта вы потеряете доступ ко всем своим данным и не сможете восстановить свою учетную запись.',
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
                final Future<bool> result =
                    context.read<AuthCubit>().deleteAccaunt();

                if (await result) {
                  if (context.mounted) {
                    context.go(Routes.unauthenticatedInvite);
                  }
                }
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
                Navigator.of(context).pop();
              },
              text: 'Назад',
            ),
          ],
        ),
      ),
    ),
  );
}
