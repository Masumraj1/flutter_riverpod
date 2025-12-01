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
      title: 'Riverpod FutureProvider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UsersPage(),
    );
  }
}

// -------------------------
// Simulated API Service
class ApiService {
  Future<List<String>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate network delay
    // Simulate success or error
    if (DateTime.now().second % 2 == 0) {
      return ['Alice', 'Bob', 'Charlie', 'David'];
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}

// -------------------------
// FutureProvider
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final usersFutureProvider = FutureProvider<List<String>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchUsers();
});

// -------------------------
// UI Page
class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('FutureProvider Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Users List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Handling different states of FutureProvider
            usersAsync.when(
              data: (users) => Expanded(
                child: ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(users[index]),
                    );
                  },
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error: ${error.toString()}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Refresh FutureProvider manually
                ref.refresh(usersFutureProvider);
              },
              child: const Text('Reload Users'),
            ),
          ],
        ),
      ),
    );
  }
}
