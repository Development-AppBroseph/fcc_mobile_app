import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../../shared/widgets/fade_indexed_stack.dart';
import '../../../main/presentation/widgets/cstm_bottom_nav.dart';

class ProductNotPicked extends StatefulWidget {
  const ProductNotPicked({super.key});

  @override
  State<ProductNotPicked> createState() => _ProductNotPickedState();
}

class _ProductNotPickedState extends State<ProductNotPicked> {
  int selectedIndex = 0;
  List<BottomNavBarItem> items = [
    BottomNavBarItem(
      svgPicture: SvgPicture.asset('assets/home.svg'),
    ),
    BottomNavBarItem(
      svgPicture: SvgPicture.asset('assets/person.svg'),
    ),
    BottomNavBarItem(
      svgPicture: SvgPicture.asset("assets/label.svg"),
    ),
    BottomNavBarItem(
      svgPicture: SvgPicture.asset("assets/car.svg"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        items: items,
      ),
      body: Stack(
        children: [
          FadeIndexedStack(
            index: selectedIndex,
            children: const [
              NotPicked(),
              NotPicked(),
              NotPicked(),
              NotPicked(),
            ],
          ),
        ],
      ),
    );
  }
}

class NotPicked extends StatelessWidget {
  const NotPicked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Вы еще не выбрали продукт на дегустацию",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CstmBtn(
                  onTap: () {},
                  text: "Выбрать",
                  margin: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
