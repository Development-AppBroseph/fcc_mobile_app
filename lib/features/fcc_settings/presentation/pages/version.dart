import 'package:fcc_app_front/export.dart';

class VersionPage extends StatelessWidget {
  const VersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 35.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomBackButton(),
              sized40,
              // Text(
              //   'Версия',
              //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
              //         color: primaryColorDark,
              //       ),
              // ),
              // sized30,
              // FutureBuilder(
              //   future: PackageInfo.fromPlatform(),
              //   builder: (
              //     BuildContext context,
              //     AsyncSnapshot<PackageInfo> snapshot,
              //   ) {
              //     return Text(
              //       "Версия приложения: ${snapshot.data?.version ?? 'Подождите'}",
              //       style: Theme.of(context).textTheme.bodySmall,
              //     );
              //   },
              // ),
              // Text(
              //   'Введена в действие: 15.01.2023',
              //   style: Theme.of(context).textTheme.bodySmall,
              //   textAlign: TextAlign.left,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
