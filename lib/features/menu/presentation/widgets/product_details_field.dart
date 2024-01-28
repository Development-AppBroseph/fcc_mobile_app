import 'package:fcc_app_front/export.dart';

class ProductTextDetailsField extends StatelessWidget {
  final String _title;
  final String _subtitle;

  const ProductTextDetailsField({
    required String title,
    required String subtitle,
    super.key,
  })  : _title = title,
        _subtitle = subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Text(
            _title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Expanded(child: CustomSeperator()),
          Text(
            _subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
