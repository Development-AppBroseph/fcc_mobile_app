import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';

class ChooseAddress extends StatelessWidget {
  const ChooseAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите адрес'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) {
              context.read<OrderBloc>().add(FetchAllAddreses(address: value));
            },
          ),
          BlocBuilder<OrderBloc, AddressOrderState>(
            builder: (BuildContext context, AddressOrderState state) {
              if (state is OrderSuccess) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            state.addresses[index].address.toString(),
                          ),
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
    );
  }
}
