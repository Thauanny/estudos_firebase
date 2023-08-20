import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/secondPage/presentation/pages/bloc/second_page_bloc.dart';
import 'package:flutter_application_1/src/modules/secondPage/second_page_module.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends SecondPageModule<SecondPage> {
  late final SecondPageBloc secondBloc;
  late StreamSubscription todosSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'SecondPage',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
