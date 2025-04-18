import 'package:flutter/material.dart';
import 'package:my_mobile_app/testing/face_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  
final homeIndexProvider = StateProvider<int>((ref) {
  return 0;
});
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> bodyItems = [
      Text("Testing..."),
      FaceViewTesting()
    ];
    return Scaffold(
      body: bodyItems[ref.watch(homeIndexProvider)],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => ref.read(homeIndexProvider.notifier).state = index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
      ),
    );
  }
}