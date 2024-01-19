import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/shared/widgets/fade_indexed_stack.dart';

class ProductNotPicked extends StatefulWidget {
  const ProductNotPicked({super.key});

  @override
  State<ProductNotPicked> createState() => _ProductNotPickedState();
}

class _ProductNotPickedState extends State<ProductNotPicked> {
  int selectedIndex = 0;
  //WTF
  List<BottomNavBarItem> items = <BottomNavBarItem>[
    BottomNavBarItem(
      svgPicture: SvgPicture.asset('assets/home.svg'),
    ),
    BottomNavBarItem(
      svgPicture: SvgPicture.asset('assets/person.svg'),
    ),
    BottomNavBarItem(
      svgPicture: SvgPicture.asset('assets/label.svg'),
    ),
    BottomNavBarItem(
      svgPicture: SvgPicture.asset('assets/car.svg'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onChanged: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        items: items,
      ),
      body: Stack(
        children: <Widget>[
          FadeIndexedStack(
            index: selectedIndex,
            children: const <Widget>[
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

// TODO: Take out to another file
class NotPicked extends StatelessWidget {
  const NotPicked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Text(
                'Вы еще не выбрали продукт на дегустацию',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: CstmBtn(
                  onTap: () {},
                  text: 'Выбрать',
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
