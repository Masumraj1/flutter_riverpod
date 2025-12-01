import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routes/app_router.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 776), // original design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.route,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}


// Provider তৈরি
final counterProvider = StateProvider<int>((ref) => 0);

// UI তে ব্যবহার
class CounterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $count', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // মান বাড়ানো
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                // মান কমানো
                ref.read(counterProvider.notifier).state--;
              },
              child: Text('Decrement'),
            ),
            ElevatedButton(
              onPressed: () {
                // মান রিসেট
                ref.read(counterProvider.notifier).state = 0;
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}