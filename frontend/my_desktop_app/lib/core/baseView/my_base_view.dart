import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class MyBaseViewClass extends ConsumerWidget {
  const MyBaseViewClass({super.key});

  // ignore: recursive_getters
  BuildContext get context => context;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Column(
        children: [
          buildTopBarArea(),
          buildMainContentArea()
        ],
      )
    );
  }


  // Sidebar
  Widget buildTopBarArea();

  // Main content area
  Widget buildMainContentArea();
}
