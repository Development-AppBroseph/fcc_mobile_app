import 'package:fcc_app_front/export.dart';

class FscDataPage extends StatelessWidget {
  const FscDataPage({
    super.key,
    required this.data,
  });
  final MapEntry data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  child: const CustomBackButton(),
                ),
                sized10,
                Text(
                  data.key,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: primaryColorDark,
                      ),
                ),
                sized30,
                AutoSizeText(
                  data.value,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                sized20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
