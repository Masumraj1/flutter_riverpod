import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// Main App
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 776), // Original design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Riverpod Counter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // যদি routerConfig ব্যবহার করো, uncomment করো
          // routerConfig: AppRouter.route,
          home: const CounterPage(),
        );
      },
    );
  }
}

// -----------------------------
// Provider তৈরি
final counterProvider = StateProvider<int>((ref) => 0);

// -----------------------------
// UI তে ব্যবহার
class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider এর মান watch করে UI rebuild
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Counter Example'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $count', style: TextStyle(fontSize: 28.sp)),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Increment', style: TextStyle(fontSize: 18.sp)),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state--;
              },
              child: Text('Decrement', style: TextStyle(fontSize: 18.sp)),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state = 0;
              },
              child: Text('Reset', style: TextStyle(fontSize: 18.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
