import 'package:flutter/material.dart';

class PushBackWidget extends StatelessWidget {
  const PushBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child: Text('ExamplePage', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))),
      ),
      body: GestureDetector(
          onTap: (() => Navigator.pop(context)),
          child: const Center(child: Text('Back', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)))
      )
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child: Text('ExamplePage', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))),
      ),
      body: const Text('EmptyPage', textAlign: TextAlign.center, style: TextStyle(color: Colors.black))
    );
  }

}
