import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:filters_widget/slider.dart';
import 'package:filters_widget/push_back_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder> {
      '/reset': (BuildContext context) => const ProviderScope(child:Page()),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const ProviderScope(child:Page()),
    );
  }
}


class Page extends StatelessWidget {
  const Page({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child: Text('Фильтр', 
          textAlign: TextAlign.center, 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400))
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                Container(
                  width: 400,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ExpansionTile(title: const Title(),
                    textColor: const Color(0xFFEB5A0F),
                    iconColor: const Color(0xFFEB5A0F),
                    children: [
                      SelectContainer(text: '1'),
                      SelectContainer(text: '2'),
                      SelectContainer(text: '3')
                    ],
                  ),
                ),
                Container(
                  width: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ExpansionTile(title: const Text('Бренд'),
                    textColor: const Color(0xFFEB5A0F),
                    iconColor: const Color(0xFFEB5A0F),
                    children: [
                      TextSelectContainer(text: '1'),
                      TextSelectContainer(text: '2'),
                      TextSelectContainer(text: '3')
                    ],
                  ),
                ),
                Container(
                  width: 400,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ExpansionTile(title: const Text('Страна производитель'),
                    textColor: const Color(0xFFEB5A0F),
                    iconColor: const Color(0xFFEB5A0F),
                    children: [
                      TextSelectContainer(text: '1'),
                      TextSelectContainer(text: '2'),
                      TextSelectContainer(text: '3')
                    ],
                  ),
                ),
                Container(width: 400, 
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
                    child: const Align(alignment: Alignment.centerLeft, 
                      child: Text('Цена', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)
                    )
                  )
                ),
                PriceSlider(),
                ],
              ),
            ),
            Container(
              width: 400,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
              child: Row(children: [
                    Expanded(
                      child: GestureDetector(
                      onTap: () => Navigator.popAndPushNamed(context, "/reset"),
                      child: Center(child: Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: const Text('Очистить', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFEB5A0F))))
                        )
                      ),
                    ),
                    Container(width: 10),
                    Expanded(child: ElevatedButton(
                      style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(color: Color(0xFFEB5A0F))
                          )
                        )
                      ),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PushBackWidget())),
                      child: const Text('Применить', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFEB5A0F)))
                      )
                    )
                  ]
                ),
              )
            ]
          )
      )
    );
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class Title extends ConsumerWidget {
  const Title({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text('Тип товара (${ref.watch(counterProvider)})');
  }
}

class SelectContainer extends ConsumerWidget {
  final String text;
  final _selectedContainerProvider = StateProvider<bool>((ref) => false);
  SelectContainer({Key? key, required this.text }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: SelectableContainer(
        iconAlignment: const Alignment(10, 0.0),
        iconSize: 10,
        selected: ref.watch(_selectedContainerProvider),
        selectedBorderColor: const Color(0xFFEB5A0F),
        selectedBackgroundColor: Colors.grey.shade100,
        unselectedBorderColor: Colors.black,
        unselectedBackgroundColor: Colors.grey.shade200,
        onValueChanged: (s) {
          if(s == true) {
            ref.read(counterProvider.state).state++;
          }
          if(s == false) {
            ref.read(counterProvider.state).state--;
          }
          ref.read(_selectedContainerProvider.state).state = s;
        },
        child: SizedBox(width: 400, child: Container(margin: const EdgeInsets.symmetric(horizontal: 10),child: Text(text)))
      ),
    );
  }
}

class TextSelectContainer extends ConsumerWidget{
  final String text;
  TextSelectContainer({Key? key, required this.text}) : super(key: key);
  final _selectedContainerProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: SelectableContainer(
        iconAlignment: const Alignment(10, 0.0),
        iconSize: 10,
        selected: ref.watch(_selectedContainerProvider),
        selectedBorderColor: const Color(0xFFEB5A0F),
        selectedBackgroundColor: Colors.grey.shade100,
        unselectedBorderColor: Colors.black,
        unselectedBackgroundColor: Colors.grey.shade200,
        onValueChanged: (s) {
          ref.read(_selectedContainerProvider.state).state = s;
        },
        child: SizedBox(width: 400, child: Container(margin: const EdgeInsets.symmetric(horizontal: 10),child: Text(text)))
      ),
    );
  }
}