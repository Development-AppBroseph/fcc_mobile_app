import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';

class ChooseAddress extends StatefulWidget {
  ChooseAddress({super.key});

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Выберите адрес',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColorDark,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String address) {
                context
                    .read<OrderBloc>()
                    .add(FetchAllAddreses(address: address));
              },
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
              decoration: InputDecoration(
                hintText: 'Поиск',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1.5,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1.5,
                  ),
                ),
              ),
              controller: address,
            ),
            BlocBuilder<OrderBloc, AddressOrderState>(
              builder: (BuildContext context, AddressOrderState state) {
                if (state is OrderSuccess) {
                  return Expanded(
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        shrinkWrap: true,
                        addAutomaticKeepAlives: true,
                        physics: const ClampingScrollPhysics(),
                        cacheExtent: 30,
                        itemBuilder: (BuildContext context, int index) {
                          final address = state.addresses[index].address!
                              .replaceRange(0, 7, '');
                          return ListTile(
                            splashColor: Theme.of(context).primaryColor,
                            title: Text(
                              'Улица:${address}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                            ),
                            subtitle: Text(
                              'Индекс: ${state.addresses[index].address!.split(',').first.trim()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                            ),
                            onTap: () {
                              context.pop(
                                <int?, String?>{
                                  state.addresses[index].id:
                                      state.addresses[index].address,
                                },
                              );
                            },
                          );
                        },
                        itemCount: state.addresses.length),
                  );
                } else if (state is OrderLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                return const Center(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }

  String removeIndexFromAddress(String address) {
    List<String> parts = address.split(', ');
    if (parts.length > 1 && parts[0].contains(RegExp(r'^\d{6}$'))) {
      parts.removeAt(0);
    }
    return parts.join(', ');
  }
}
