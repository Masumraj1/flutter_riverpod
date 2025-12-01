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
      title: 'AsyncNotifierProvider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UsersPage(),
    );
  }
}

// -------------------------
// AsyncNotifier (Riverpod v2)
class UsersNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    // initial fetch
    await Future.delayed(const Duration(seconds: 2));
    return ['Alice', 'Bob', 'Charlie'];
  }

  // refresh / reload users
  Future<void> reloadUsers() async {
    state = const AsyncLoading();
    try {
      await Future.delayed(const Duration(seconds: 2));
      state = AsyncData(['Alice', 'Bob', 'Charlie', 'David']);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// AsyncNotifierProvider
final usersProvider =
AsyncNotifierProvider<UsersNotifier, List<String>>(UsersNotifier.new);

// -------------------------
// UI Page
class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('AsyncNotifierProvider Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Users List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Handling Async state
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
              error: (err, stack) => Center(
                child: Text(
                  'Error: $err',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Reload users
                ref.read(usersProvider.notifier).reloadUsers();
              },
              child: const Text('Reload Users'),
            ),
          ],
        ),
      ),
    );
  }
}
