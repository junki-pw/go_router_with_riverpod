import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_with_riverpod/test_river_pod_watch_screen.dart';

import 'go_router_notifier.dart';
import 'main.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.read(goNotifyProvider);
  bool isFirstRedirect = false;
  String? firstLocation; //ブラウザから直接入力した際のlocation

  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier, // 検知して、処理を行う為のChangeNotifier
    redirect: (context, state) async {
      /// ここの中で、普通にログインチェックしたら問題なさそう
      /// ただし、ここで毎回isSignedInとかしてたら無駄だから、やり方は考える
      /// 既にログインしている場合の２重チェックをisDuplicateみたいな感じで変数を持つ

      if (!isFirstRedirect) {
        firstLocation = state.location;
        if (kDebugMode) print('firstUrlPath: $firstLocation');
        isFirstRedirect = true;
      }
      if (kDebugMode) print('location: ${state.location}');
      // final testM = ref.read(goNotifyProvider);
      //
      // var isLogin = testM.isLogin;
      // print('isLogin: $isLogin');
      // return isLogin ? '/settings/123' : '/';
      // print('state: $state');
      // var index = 1;
      // if (index == 1) return '/test_river_pod_watch';
      return null;
    },
    routes: [
      GoRoute(
        name: "MyHomePage",
        path: '/',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: MyHomePage(),
        ),
      ),
      GoRoute(
        name: "test_river_pod_watch",
        path: '/test_river_pod_watch',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const TestRiverPodWatchScreen(),
        ),
      ),
      GoRoute(
        name: "settings",
        path: '/settings/:id',
        pageBuilder: (context, state) {
          // print('state: ${state.extra}');
          final params = state.params;
          // print('params: $params');
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const SettingsScreen(),
          );
        },
      ),
      GoRoute(
        name: "detail",
        path: "/detail/:pid",
        builder: (context, state) {
          final String id = state.params['pid']!;
          return DetailScreen(pid: id);
        },
      ),
    ],
    //遷移ページがないなどのエラーが発生した時に、このページに行く
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('エラーが発生しました' * 10),
        ),
      ),
    ),
  );
});
