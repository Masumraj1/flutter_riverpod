# 📦 ProviderScope — Riverpod এর হৃৎপিণ্ড

`ProviderScope` না থাকলে **Riverpod একদম কাজই করবে না**।  
কারণ `ProviderScope` হচ্ছে একটা **গ্লোবাল container** যেখানে আমাদের সব `provider` গুলো store হয় এবং সেখান থেকেই এগুলোকে অ্যাপে যেকোন জায়গা থেকে read / watch করা যায়।

সাধারণত আমরা `main.dart` ফাইলে পুরো অ্যাপটাকে `ProviderScope` দিয়ে wrap করে দেই।

---

## 🔧 কেন ProviderScope দরকার?

- সব `provider` এর **state & lifecycle** manage করে
- যেকোন widget থেকে `ref.watch / ref.read` ব্যবহার করার সুবিধা দেয়
- Future এ চাইলে আলাদা আলাদা scope তৈরি করে **different state tree** বানানো যায়
- Testing এর সময় সহজে provider **override** করা যায়


```dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod ProviderScope Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
```
# 🌱 Riverpod Provider Types সম্পূর্ণ গাইড
Flutter Riverpod-এ বিভিন্ন ধরনের Provider আছে। প্রতিটি Provider এর নিজস্ব কাজ এবং ব্যবহার রয়েছে। এই গাইডে সব Provider Type বাংলায় বিস্তারিত আলোচনা করা হয়েছে।

---

## 📦 সূচিপত্র

- StateProvider
- Provider
- FutureProvider
- StreamProvider
- StateNotifierProvider
- ChangeNotifierProvider
- NotifierProvider
- AsyncNotifierProvider
- ref এর ব্যবহার

---

### 1️⃣ `StateProvider` কী এবং কেন?
StateProvider হলো Riverpod এর সবচেয়ে simple provider, যা একটি single value বা state store করতে ব্যবহার হয়।
এটি সাধারণত ছোটখাটো, simple UI state–এর জন্য ব্যবহার হয়।
StateProvider ব্যবহার করলে UI কে reactive করা যায় ref.watch() দিয়ে, এবং state change করা যায় ref.read() বা notifier দিয়ে।

**কখন ব্যবহার করবে?**

- Simple counter
- Toggle button (true/false)
- Dropdown selection
- TextField এর temporary value
- Theme mode (light/dark)

[State Provider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/state_provider)

------

### 1️⃣ `StateProvider` কী এবং কেন?
StateProvider হলো Riverpod এর সবচেয়ে simple provider, যা একটি single value বা state store করতে ব্যবহার হয়।
এটি সাধারণত ছোটখাটো, simple UI state–এর জন্য ব্যবহার হয়।
StateProvider ব্যবহার করলে UI কে reactive করা যায় ref.watch() দিয়ে, এবং state change করা যায় ref.read() বা notifier দিয়ে।

**কখন ব্যবহার করবে?**

- Simple counter
- Toggle button (true/false)
- Dropdown selection
- TextField এর temporary value
- Theme mode (light/dark)

[State Provider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/state_provider)

---

#### Copywith method
* select() → নির্দিষ্ট property watch করো, অপ্রয়োজনীয় rebuild কমবে।
* autoDispose
* loose coupling and tight coupling
* ConsumerWidget ছাড়া তুমি ref পাবা না → তাই provider এর state access করতে পারবে না।
* এক কথায়: “ConsumerWidget হলো Riverpod এর interface যা দিয়ে provider এর state UI তে দেখানো যায়।”
### StatelessWidget + Consumer ====যখন performance গুরুত্বপূর্ণ, বড় widget tree আছে, শুধুমাত্র ছোট অংশ rebuild করতে হবে
### ConsumerWidget             ====যখন পুরো widget ছোট এবং state change হলে পুরোটা rebuild হলেও কোনো সমস্যা নেই
* https://github.com/Uuttssaavv/flutter-clean-architecture-riverpod
* https://dev.to/ssoad/flutter-riverpod-clean-architecture-the-ultimate-production-ready-template-for-scalable-apps-gdh
* https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/

* Providers?
* ConsumerWidget
* ConsumerStatefulWidget

* 



* Riverpod Setup
  Main>>ProviderScope


* Easy level

// StateProvider
// final riverpodEasyLevel = StateProvider<int>((ref){
//return 0});
)

// ConsumerWidget ====WidgetRef ref
//ref.watch(riverpod)  == watch == always listen to changes
//ref.read(riverpod.notifier).state == don't listen to changes


* Hard Level
 //ChangeNotifierProvider
  // final riverpodHardlevel = ChangeNotifierProvider<RiverpodModel>((ref){
  //return RiverpodModel{counter:0);});
  )

//ChangeNotifier
// RiverpodModel == extends ChangeNotifier

//notifyListeners

// ConsumerWidget ====WidgetRef ref
//ref.watch(riverpod).name  == watch == always listen to changes
//ref.read(riverpod).changename(newName:newValue) == don't listen to changes



///gemini
//
// Riverpod State Management Tutorial (Bangla)
// এই ফাইলটি Riverpod-এর বেসিক থেকে ইন্টারমিডিয়েট ধারণা দেওয়ার জন্য তৈরি।
//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -----------------------------------------------------------------------------
// ১. Provider সংজ্ঞা (Global State Definition)
// -----------------------------------------------------------------------------

// ** ১.১. Provider (Read-only Value) **
// এটি অপরিবর্তনশীল (Immutable) বা রিড-অনলি ডেটা প্রদান করে, যা পরিবর্তন হয় না।
final simpleTitleProvider = Provider<String>((ref) {
return "রিভারপড স্টেট ম্যানেজমেন্ট ডেমো"; // অ্যাপ্লিকেশনের প্রধান টাইটেল
});

// ** ১.২. StateProvider (Simple Mutable State) **
// এটি সহজ পরিবর্তনশীল (Mutable) স্টেট যেমন boolean বা string-এর জন্য ব্যবহৃত হয়।
// এখানে আমরা ডার্ক মোড টগল করার জন্য এটি ব্যবহার করছি।
final darkModeProvider = StateProvider<bool>((ref) => false); // প্রাথমিক মান: false (লাইট মোড)

// ** ১.৩. Notifier & NotifierProvider (Complex State and Business Logic) **
// StateNotifier/Notifier হলো জটিল স্টেট (যেমন: একটি ক্লাস বা লিস্ট) এবং
// সেটির সাথে সম্পর্কিত লজিক (বিজনেস লজিক) পরিচালনার আধুনিক উপায়।
class CounterNotifier extends Notifier<int> {
// Notifier-এর প্রাথমিক মান সেট করা হয় build() মেথডে।
@override
int build() {
return 0; // প্রাথমিক কাউন্টার ভ্যালু
}

// কাউন্টার বাড়ানোর ফাংশন
void increment() {
state = state + 1; // 'state' হলো Notifier-এর বর্তমান ভ্যালু
}

// কাউন্টার কমানোর ফাংশন
void decrement() {
state = state - 1;
}
}

// NotifierProvider তৈরি করা হচ্ছে। UI এই প্রোভাইডারটি ব্যবহার করবে।
final counterNotifierProvider = NotifierProvider<CounterNotifier, int>(
() => CounterNotifier(),
);


// ** ১.৪. FutureProvider (Asynchronous Data Handling) **
// এটি কোনো অ্যাসিঙ্ক্রোনাস অপারেশন (যেমন: API কল) থেকে প্রাপ্ত ডেটা পরিচালনা করে।
// এটি স্বয়ংক্রিয়ভাবে লোডিং, ডেটা এবং এরর স্টেট পরিচালনা করে।

// মক ইউজার ডেটা মডেল
class User {
final int id;
final String name;
User({required this.id, required this.name});
}

// ডেটা আনার জন্য মক সার্ভিস
class UserService {
Future<List<User>> fetchUsers() async {
// 2 সেকেন্ড অপেক্ষা করে ডেটা আনার অভিনয়
await Future.delayed(const Duration(seconds: 2));
return [
User(id: 1, name: 'আরিফ রহমান'),
User(id: 2, name: 'তাসমিয়া জাহান'),
User(id: 3, name: 'নিলয় চৌধুরী'),
];
}
}

// FutureProvider সংজ্ঞা
final userListFutureProvider = FutureProvider<List<User>>((ref) {
// যখনই এই প্রোভাইডারটি শোনা হবে, তখনই fetchUsers কল হবে।
return UserService().fetchUsers();
});

// -----------------------------------------------------------------------------
// ২. মূল অ্যাপ্লিকেশন এবং ProviderScope
// -----------------------------------------------------------------------------

void main() {
// Riverpod ব্যবহার করার জন্য অবশ্যই পুরো অ্যাপটিকে ProviderScope দিয়ে র‍্যাপ করতে হবে।
runApp(
const ProviderScope(
child: MyApp(),
),
);
}

class MyApp extends ConsumerWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
// darkModeProvider-এর মান দেখুন। 'ref.watch' স্টেট পরিবর্তন হলে UI রিবিল্ড করে।
final isDarkMode = ref.watch(darkModeProvider);
final appTitle = ref.watch(simpleTitleProvider); // রিড-অনলি টাইটেল ওয়াচ করা হচ্ছে

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
}
}

// -----------------------------------------------------------------------------
// ৩. UI কম্পোনেন্টসমূহ (Riverpod ব্যবহার করে)
// -----------------------------------------------------------------------------

class HomePage extends StatelessWidget {
const HomePage({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const SimpleValueWidget(), // Provider ব্যবহার
actions: const [
StateProviderToggle(), // StateProvider ব্যবহার
],
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: const [
Card(
elevation: 4,
child: Padding(
padding: EdgeInsets.all(16.0),
child: CounterWidget(), // NotifierProvider ব্যবহার
),
),
SizedBox(height: 20),
Card(
elevation: 4,
child: Padding(
padding: EdgeInsets.all(16.0),
child: AsyncDataWidget(), // FutureProvider ব্যবহার
),
),
],
),
),
);
}
}

//
// ৩.১. SimpleValueWidget (Provider-এর উদাহরণ)
//
class SimpleValueWidget extends ConsumerWidget {
const SimpleValueWidget({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
// simpleTitleProvider থেকে মান পড়ার জন্য ref.watch ব্যবহার করা হচ্ছে।
final title = ref.watch(simpleTitleProvider);

    return Text(title);
}
}

//
// ৩.২. StateProviderToggle (StateProvider-এর উদাহরণ)
//
class StateProviderToggle extends ConsumerWidget {
const StateProviderToggle({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
// 'ref.watch' ব্যবহার করে ডার্ক মোডের বর্তমান স্টেট পড়ুন।
final isDarkMode = ref.watch(darkModeProvider);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Switch(
        value: isDarkMode,
        onChanged: (newValue) {
          // 'ref.read' ব্যবহার করে প্রোভাইডারের Notifier (StateController) এ প্রবেশ করুন
          // এবং তার state পরিবর্তন করুন।
          ref.read(darkModeProvider.notifier).state = newValue;
        },
      ),
    );
}
}

//
// ৩.৩. CounterWidget (NotifierProvider-এর উদাহরণ)
//
class CounterWidget extends ConsumerWidget {
const CounterWidget({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
// 'ref.watch' ব্যবহার করে কাউন্টারের বর্তমান ইন্টিজার মান পড়ুন।
final counterValue = ref.watch(counterNotifierProvider);

    // Riverpod-এর ref.listen() ব্যবহার করে স্টেট পরিবর্তনের প্রতিক্রিয়া দেখুন।
    ref.listen<int>(counterNotifierProvider, (previous, next) {
      if (next > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('কাউন্টার ৫ ছাড়িয়ে গেছে!'),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'কাউন্টার নোটিফায়ার (জটিল স্টেট)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '$counterValue',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Notifier-এর ফাংশন কল করতে: ref.read(provider.notifier)
                ref.read(counterNotifierProvider.notifier).decrement();
              },
              child: const Text('কমানো (-)', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                // Notifier-এর ফাংশন কল করতে: ref.read(provider.notifier)
                ref.read(counterNotifierProvider.notifier).increment();
              },
              child: const Text('বাড়ানো (+)', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ],
    );
}
}

//
// ৩.৪. AsyncDataWidget (FutureProvider-এর উদাহরণ)
//
class AsyncDataWidget extends ConsumerWidget {
const AsyncDataWidget({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
// FutureProvider ওয়াচ করুন। 'when' মেথড লোডিং, ডেটা, এবং এরর স্টেট পরিচালনা করে।
final asyncUsers = ref.watch(userListFutureProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ফিউচার প্রোভাইডার (Async ডেটা)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        asyncUsers.when(
          // যখন ডেটা লোড হচ্ছে
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          ),

          // যখন কোনো এরর হয়েছে
          error: (err, stack) => Center(
            child: Text('ডেটা লোডে এরর: $err'),
          ),

          // যখন ডেটা সফলভাবে পাওয়া গেছে
          data: (users) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'প্রাপ্ত ইউজার তালিকা:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                ...users.map((user) => ListTile(
                  leading: CircleAvatar(
                    child: Text('${user.id}'),
                  ),
                  title: Text(user.name),
                  subtitle: const Text('ইউজার ডেটা সফল'),
                )),
              ],
            );
          },
        ),
      ],
    );
}
}




//==============CloudAi--------------
# Riverpod State Management - সম্পূর্ণ বাংলা গাইড

## সূচিপত্র
1. [Riverpod কি?](#riverpod-কি)
2. [Setup এবং Installation](#setup-এবং-installation)
3. [Basic Concepts](#basic-concepts)
4. [Provider Types](#provider-types)
5. [Practical Examples](#practical-examples)
6. [Best Practices](#best-practices)

---

## Riverpod কি?

Riverpod হল Flutter এর জন্য একটি শক্তিশালী এবং আধুনিক state management solution। এটি Provider package এর উন্নত সংস্করণ।

### কেন Riverpod ব্যবহার করবেন?

- ✅ **Compile-time safety**: Runtime error এর বদলে compile-time error
- ✅ **No BuildContext**: Provider পড়তে BuildContext লাগে না
- ✅ **Testable**: সহজে unit test করা যায়
- ✅ **Flexible**: যেকোনো জায়গা থেকে access করা যায়

---

## Setup এবং Installation

### ১. Dependencies যোগ করুন

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9

dev_dependencies:
  riverpod_generator: ^2.3.9
  build_runner: ^2.4.6
  riverpod_lint: ^2.3.7
```

### ২. Main.dart Setup

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // ProviderScope দিয়ে পুরো app wrap করতে হবে
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Demo',
      home: const HomePage(),
    );
  }
}
```

---

## Basic Concepts

### ১. Provider কি?

Provider হল একটি object যা state hold করে এবং সেই state অন্যান্য widget এ share করে।

### ২. Consumer কি?

Consumer হল একটি widget যা provider থেকে data read করে এবং UI rebuild করে যখন data change হয়।

### ৩. Ref কি?

Ref হল একটি object যা provider এর সাথে interact করতে সাহায্য করে।

---

## Provider Types

### ১. Provider (Simple Read-only)

সবচেয়ে basic provider। শুধুমাত্র read করার জন্য।

```dart
// একটি simple string provider
final helloWorldProvider = Provider<String>((ref) {
  return 'Hello World!';
});

// ব্যবহার
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(helloWorldProvider);
    
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}
```

### ২. StateProvider (Simple State)

Simple state manage করার জন্য। যেমন: counter, toggle, etc.

```dart
// Counter provider
final counterProvider = StateProvider<int>((ref) {
  return 0; // initial value
});

// ব্যবহার
class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text(
          'Count: $count',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // State update করা
          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### ৩. StateNotifierProvider (Complex State)

Complex state এবং logic এর জন্য।

```dart
// Todo Model
class Todo {
  final String id;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// StateNotifier class
class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  // Todo add করা
  void addTodo(String title) {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
    );
    state = [...state, newTodo];
  }

  // Todo toggle করা
  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  // Todo remove করা
  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

// Provider
final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

// ব্যবহার
class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isCompleted 
                  ? TextDecoration.lineThrough 
                  : null,
              ),
            ),
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) {
                ref.read(todoProvider.notifier).toggleTodo(todo.id);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(todoProvider.notifier).removeTodo(todo.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add todo dialog দেখানো
          _showAddTodoDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('নতুন Todo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Todo লিখুন'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(todoProvider.notifier).addTodo(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
```

### ৪. FutureProvider (Async Data)

API call বা async operation এর জন্য।

```dart
// User Model
class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

// API Service
class ApiService {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    
    // Dummy data
    return [
      User(id: 1, name: 'রহিম', email: 'rahim@example.com'),
      User(id: 2, name: 'করিম', email: 'karim@example.com'),
      User(id: 3, name: 'সালমা', email: 'salma@example.com'),
    ];
  }
}

// FutureProvider
final userProvider = FutureProvider<List<User>>((ref) async {
  final apiService = ApiService();
  return apiService.fetchUsers();
});

// ব্যবহার
class UserListPage extends ConsumerWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: usersAsync.when(
        data: (users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(child: Text(user.name[0])),
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
```

### ৫. StreamProvider (Real-time Data)

Real-time data বা stream এর জন্য।

```dart
// Stream Provider
final timerProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (count) => count,
  );
});

// ব্যবহার
class TimerPage extends ConsumerWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerAsync = ref.watch(timerProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: Center(
        child: timerAsync.when(
          data: (count) => Text(
            'Seconds: $count',
            style: const TextStyle(fontSize: 30),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
```

---

## Practical Examples

### Example ১: Shopping Cart

```dart
// Product Model
class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

// Cart Item Model
class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

// Cart Notifier
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addProduct(Product product) {
    final existingIndex = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      state = [
        for (var i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i],
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeProduct(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }

    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: quantity)
        else
          item,
    ];
  }

  void clearCart() {
    state = [];
  }

  double get total {
    return state.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}

// Providers
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(
    0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );
});

// Product List Provider
final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(id: '1', name: 'চাল', price: 50.0),
    Product(id: '2', name: 'ডাল', price: 120.0),
    Product(id: '3', name: 'তেল', price: 180.0),
  ];
});

// UI
class ShoppingPage extends ConsumerWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final cart = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('৳${total.toStringAsFixed(2)}'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('৳${product.price}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addProduct(product);
                    },
                    child: const Text('Add'),
                  ),
                );
              },
            ),
          ),
          if (cart.isNotEmpty) ...[
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cart Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return ListTile(
                    title: Text(item.product.name),
                    subtitle: Text('৳${item.product.price} x ${item.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            ref.read(cartProvider.notifier).updateQuantity(
                              item.product.id,
                              item.quantity - 1,
                            );
                          },
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            ref.read(cartProvider.notifier).updateQuantity(
                              item.product.id,
                              item.quantity + 1,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
```

---

## Best Practices

### ১. Provider Organization

```dart
// providers/providers.dart - সব provider এক জায়গায়
final counterProvider = StateProvider<int>((ref) => 0);
final userProvider = FutureProvider<User>((ref) async => fetchUser());
```

### ২. ref.watch vs ref.read vs ref.listen

```dart
// ref.watch - UI rebuild করবে যখন state change হবে
final count = ref.watch(counterProvider);

// ref.read - শুধু একবার পড়বে, rebuild করবে না
ref.read(counterProvider.notifier).state++;

// ref.listen - state change এ callback execute করবে
ref.listen(counterProvider, (previous, next) {
  if (next > 10) {
    showDialog(...);
  }
});
```

### ৩. Provider Modifiers

```dart
// .family - dynamic parameter pass করা
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
  return fetchUser(userId);
});

// ব্যবহার
final user = ref.watch(userProvider('123'));

// .autoDispose - automatic cleanup
final timerProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
```

### ৪. ConsumerWidget vs Consumer

```dart
// ConsumerWidget - পুরো widget rebuild হবে
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}

// Consumer - শুধু নির্দিষ্ট অংশ rebuild হবে
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Static text'),
        Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            return Text('$count');
          },
        ),
      ],
    );
  }
}
```

---

## সংক্ষিপ্ত সারাংশ

1. **Provider**: Simple, read-only data
2. **StateProvider**: Simple state (counter, toggle)
3. **StateNotifierProvider**: Complex state + logic
4. **FutureProvider**: Async operations (API calls)
5. **StreamProvider**: Real-time data streams

### মূল পয়েন্ট:
- `ProviderScope` দিয়ে app wrap করতে হবে
- `ConsumerWidget` বা `Consumer` ব্যবহার করতে হবে
- `ref.watch` UI update এর জন্য
- `ref.read` action/method call এর জন্য
- State immutable রাখতে হবে

---

## Resources

- [Official Documentation](https://riverpod.dev)
- [GitHub Examples](https://github.com/rrousselGit/riverpod/tree/master/examples)
- [Pub.dev Package](https://pub.dev/packages/flutter_riverpod)

এই tutorial টি basic থেকে intermediate level পর্যন্ত Riverpod এর সব কিছু cover করেছে। Practice করার মাধ্যমে আপনি expert হয়ে যাবেন! 🚀
