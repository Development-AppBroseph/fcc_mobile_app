import 'package:fcc_app_front/export.dart';

class FirstReadMessage extends StatelessWidget {
  const FirstReadMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/avatars/fsk.png',
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Поддержка',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 300.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 300.w,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Запрос передан специалистам',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
