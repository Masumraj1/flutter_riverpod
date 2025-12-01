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
      title: 'Riverpod Provider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// -------------------------
// 1️⃣ Read-only Provider Examples

// Example 1: Simple immutable value (configuration)
final baseUrlProvider = Provider<String>((ref) => 'https://api.example.com');

// Example 2: Duration configuration
final timeoutProvider = Provider<Duration>((ref) => const Duration(seconds: 30));

// Example 3: Computed value based on another provider
final ageProvider = StateProvider<int>((ref) => 20); // mutable state
final isAdultProvider = Provider<bool>((ref) {
  final age = ref.watch(ageProvider); // watch other provider
  return age >= 18;
});

// Example 4: Service/Repository injection
class ApiService {
  Future<List<String>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['Alice', 'Bob', 'Charlie'];
  }
}

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// -------------------------
// UI Page
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read-only Providers
    final baseUrl = ref.watch(baseUrlProvider);
    final timeout = ref.watch(timeoutProvider);
    final isAdult = ref.watch(isAdultProvider);

    // Accessing API Service (read-only)
    final apiService = ref.read(apiServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Provider Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "1️⃣ Read-only Provider Examples",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Base URL: $baseUrl', style: const TextStyle(fontSize: 16)),
            Text('Timeout: ${timeout.inSeconds} seconds', style: const TextStyle(fontSize: 16)),
            Text('Is Adult: $isAdult', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Using read-only provider to call a service
                final users = await apiService.fetchUsers();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Users: ${users.join(", ")}')),
                );
              },
              child: const Text('Fetch Users from ApiService'),
            ),
          ],
        ),
      ),
    );
  }
}
