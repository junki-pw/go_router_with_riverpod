import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'go_router_notifier.dart';
import 'go_router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _router = ref.watch(routerProvider);
    // Future(() async {
    //   await Future.delayed(Duration(seconds: 3));
    //   context.go('/settings/id');
    // });

    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    Future(() async {
      print('MyHomePage');
      // await Future.delayed(Duration(seconds: 3));
      // context.go('/settings/id');
    });
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/settings/id', extra: '引数入れました');
            },
            child: Text('test'),
          ),
          ElevatedButton(
            onPressed: () {
              context.push('/test_river_pod_watch', extra: '引数入れました');
            },
            child: Text('test_river_pod_watch'),
          ),
          ElevatedButton(
            onPressed: () {
              print('スタート');
              ref.read(goNotifyProvider).updateLoginStatus();
              print('終了');
            },
            child: Text('test'),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('SettingsScreen'),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.pid}) : super(key: key);
  final String pid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('DetailScreen: $pid'),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('戻る'),
          ),
        ],
      ),
    );
  }
}
