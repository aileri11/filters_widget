import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceSlider extends ConsumerWidget {
  PriceSlider({Key? key}) : super(key: key);
  final _rangeProvider = StateProvider<RangeValues>((ref) => const RangeValues(0.0, 1000000.0));
  final _startEditingProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
  final _endEditingProvider = StateProvider<TextEditingController>((ref) => TextEditingController());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Center(child: 
        Column(
          children: [
            Row(children: [
              Expanded(
                child: Container(alignment: Alignment.centerLeft, 
                  width: 180,
                  child: TextField(
                  controller: ref.watch(_startEditingProvider),
                  decoration: const InputDecoration(
                    label: Text('от', style: TextStyle(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEB5A0F), width: 1.0)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                  onSubmitted: (s){
                    if(s != ''){
                      ref.read(_rangeProvider.state).state = RangeValues(double.parse(s), ref.watch(_rangeProvider).end );}
                  },
                )
                ),
              ),
              Container(width: 10),
              Expanded(
                child: Container(alignment: Alignment.centerRight, 
                  width: 180,
                  child: TextField(
                  controller: ref.watch(_endEditingProvider),
                  decoration: const InputDecoration(
                    label: Text('до', style: TextStyle(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFEB5A0F), width: 1.0)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                  ),
                  onSubmitted: (s){
                    if(s != ''){
                      ref.read(_rangeProvider.state).state = RangeValues(ref.watch(_rangeProvider).start, double.parse(s));}
                    },
                  )
                ),
              )
            ]),
            RangeSlider(
              activeColor: const Color(0xFFEB5A0F),
              values: ref.watch(_rangeProvider),
              onChanged: (RangeValues range) {
                ref.read(_rangeProvider.notifier).state = range;
                ref.read(_startEditingProvider.state).state.text = range.start.round().toString();
                ref.read(_endEditingProvider.state).state.text = range.end.round().toString(); 
              },
              max: 1000000,
              
            )
          ]
        )
      ),
    );
  }
}
