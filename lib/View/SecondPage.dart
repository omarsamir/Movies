import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final wordPair = WordPair.random();
    return Scaffold(
      // Add 6 lines from here...
      appBar: AppBar(
        title: Text('Details'),
      ),
      body:Text('Hello Second page'),
    ); // ...  
  }

  Widget mainSecondPage(){
  return  Scaffold(
      // Add 6 lines from here...
      appBar: AppBar(
        title: Text('Details'),
      ),
      body:Text('Hello Second page'),
    ); // ... 
  }
}