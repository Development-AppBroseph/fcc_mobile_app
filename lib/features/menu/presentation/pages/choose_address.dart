import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';
import 'package:fcc_app_front/shared/utils/debouncer.dart';

class ChooseAddress extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController appartmentController = TextEditingController();

  final Debouncer debouncer = Debouncer(milliseconds: 1000);
  ChooseAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.maxWidth;

        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Введите адрес',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
          ),
          body: Padding(
            padding: boxWidth < 600
                ? const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  )
                : EdgeInsets.only(
                    left: 30 + (boxWidth - 600) / 2,
                    right: 30 + (boxWidth - 600) / 2,
                  ),
            child: Column(
              children: <Widget>[
                TextField(
                  autocorrect: true,
                  onChanged: (String address) {
                    debouncer.run(() {
                      context
                          .read<OrderBloc>()
                          .add((FetchAllAddreses(address: address)));
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
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            physics: const ClampingScrollPhysics(),
                            cacheExtent: 30,
                            itemBuilder: (BuildContext context, int index) {
                              final String? address =
                                  state.addresses[index].address;
                              return ListTile(
                                splashColor: Theme.of(context).primaryColor,
                                title: Text(
                                  'Улица:$address',
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
                                  'Индекс: ${state.addresses[index].address?.split(',').first.trim()}',
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
                                            titlePadding:
                                                const EdgeInsets.all(4),
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                            icon: const Icon(Icons.home_filled),
                                            actions: <Widget>[
                                              CstmBtn(
                                                key: UniqueKey(),
                                                text: 'Добавить',
                                                onTap: () {
                                                  if (state.addresses[index]
                                                          .address !=
                                                      null) {
                                                    context.pop(<int?, String?>{
                                                      state.addresses[index].id:
                                                          '${state.addresses[index].address!.trim()}, ${appartmentController.text.trim()}',
                                                    });

                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              ),
                                              sized20,
                                              CstmBtn(
                                                color: Colors.white60,
                                                key: UniqueKey(),
                                                text: 'Закрыть',
                                                onTap: () {
                                                  if (state.addresses[index]
                                                          .address !=
                                                      null) {
                                                    context.pop(<int?, String?>{
                                                      state.addresses[index].id:
                                                          '${state.addresses[index].address!.trim()}, ',
                                                    });

                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                              ),
                                            ],
                                            title: Column(
                                              children: [
                                                Text(
                                                  'Введите номер квартиры',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                                Text(
                                                  'при необходимости',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                            content: Card(
                                              elevation: 0,
                                              color: Colors.transparent,
                                              child: CustomFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                textInputType:
                                                    TextInputType.number,
                                                hintText: 'Квартира',
                                                controller:
                                                    appartmentController,
                                              ),
                                            ));
                                      });
                                },
                              );
                            },
                            itemCount: state.addresses.length),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        );
      },
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
