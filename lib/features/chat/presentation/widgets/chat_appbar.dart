import 'package:fcc_app_front/export.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: scaffoldBackgroundColor,
      shadowColor: primaryColorDark.withOpacity(
        0.25,
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10.h,
          top: 20.h,
        ),
        decoration: const BoxDecoration(
          color: scaffoldBackgroundColor,
        ),
        child: Row(
          children: <Widget>[
            OnTapScaleAndFade(
              onTap: () {
                canPopThenPop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
                color: Theme.of(context).canvasColor,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/avatars/fsk.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Поддержка',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        'Мы всегда на связи',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.search,
              color: Theme.of(context).canvasColor,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
