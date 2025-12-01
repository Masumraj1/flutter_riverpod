import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// -------------------------
// Main App
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Riverpod StreamProvider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TimerPage(),
    );
  }
}

// -------------------------
// StreamProvider Example
// Simulate a timer stream that emits a number every second
final timerStreamProvider = StreamProvider<int>((ref) async* {
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
});

// -------------------------
// UI Page
class TimerPage extends ConsumerWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerAsync = ref.watch(timerStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StreamProvider Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Live Timer',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Handling different states of StreamProvider
            timerAsync.when(
              data: (value) => Text(
                'Timer: $value',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text(
                'Error: ${error.toString()}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                // Refresh StreamProvider manually
                ref.refresh(timerStreamProvider);
              },
              child: const Text('Restart Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
