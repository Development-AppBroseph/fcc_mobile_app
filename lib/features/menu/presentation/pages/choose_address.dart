import 'dart:async';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({super.key});

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController appartmentController = TextEditingController();

  Debouncer debounce = Debouncer(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Введите улицу',
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
              autocorrect: false,
              onChanged: (String address) {
                debounce.run(() {
                  context
                      .read<OrderBloc>()
                      .add(FetchAllAddreses(address: address));
                });
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
              controller: addressController,
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
                          final String address = state.addresses[index].address!
                              .replaceRange(0, 7, '');
                          return ListTile(
                            key: UniqueKey(),
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
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        titlePadding: const EdgeInsets.all(16),
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        icon: const Icon(Icons.home_filled),
                                        actions: <Widget>[
                                          CstmBtn(
                                            key: UniqueKey(),
                                            text: 'Добавить',
                                            onTap: () {
                                              if (appartmentController
                                                  .text.isEmpty) {
                                                ApplicationSnackBar
                                                    .showErrorSnackBar(
                                                  context,
                                                  'Пожалуйста, введите квартиру',
                                                  1,
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  1,
                                                );
                                                return;
                                              }

                                              context.pop();

                                              if (state.addresses[index]
                                                      .address !=
                                                  null) {
                                                context.pop(<int?, String?>{
                                                  state.addresses[index].id:
                                                      '${state.addresses[index].address!.trim()}, Квартира ${appartmentController.text.trim()}',
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                        title: const Text('Введите квартиру'),
                                        content: Card(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          child: CustomFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            textInputType: TextInputType.number,
                                            hintText: 'Квартира',
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Поле не может быть пустым';
                                              }
                                              return null;
                                            },
                                            controller: appartmentController,
                                          ),
                                        ));
                                  });
                            },
                          );
                        },
                        itemCount: state.addresses.length),
                  );
                } else if (state is OrderLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
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

class Debouncer {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
