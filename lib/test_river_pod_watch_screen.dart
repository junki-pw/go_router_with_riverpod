import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textProvider = StateProvider<String>((ref) {
  return 'あいうえお';
});

class TestRiverPodWatchScreen extends ConsumerWidget {
  const TestRiverPodWatchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _textProvider = ref.watch(textProvider);
    print('TestRiverPodWatchScreen');
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('あああ'),
          Text(_textProvider),
          ElevatedButton(
            onPressed: () {
              var notifier = ref.read(textProvider.notifier);
              notifier.state = 'test';
            },
            child: Text('更新する'),
          ),
        ],
      ),
    );
  }
}
