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
***
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

[State Provider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/state_provider/state_provider.dart)

---

### 2️⃣ `Provider` কী এবং কেন?
Provider হলো read-only value প্রদান করে। এর মান পরিবর্তন করা যায় না।

**কখন ব্যবহার করবে?**

- Dependency injection (Repository, Service)
- Configuration values
- Constants
- অন্য provider থেকে computed value

[Provider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/provider/provider.dart)

---
### 3️⃣` FutureProvider` কী এবং কেন?
FutureProvider asynchronous operation (যেমন API call) handle করে এবং AsyncValue return করে।

**কখন ব্যবহার করবে?**

- API থেকে data fetch
- Database query
- File reading
- যেকোনো async operation যা একবার execute হয়

**AsyncValue এর তিনটি state**

1. loading - ডেটা লোড হচ্ছে
2. data - ডেটা পাওয়া গেছে
3. error - এরর হয়েছে

[FutureProvider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/future_provider/future_provider.dart)

---

### 4️⃣`StreamProvider` কী এবং কেন?
StreamProvider continuous data stream handle করে (যেমন real-time updates)।


**কখন ব্যবহার করবে?**

- Firebase Firestore real-time updates
- WebSocket connections
- Location tracking
- Timer/Clock
- Chat messages


[StreamProvider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/stream_provider/stream_provider.dart)

---

### 5️⃣ `StateNotifierProvider` কী এবং কেন?
StateNotifierProvider complex state management এর জন্য। এটি StateNotifier class ব্যবহার করে।

**কখন ব্যবহার করবে?**

- Complex business logic
- Multiple related states
- Form validation
- Shopping cart
- Authentication flow


[StateNotifierProvider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/state_notifier_provider/state_notifier_provider.dart)

---

### 6️⃣ `ChangeNotifierProvider` কী এবং কেন?
ChangeNotifierProvider হলো Flutter এর ChangeNotifier এর সাথে কাজ করে। এটি legacy code এর জন্য ভালো।

**কখন ব্যবহার করবে?**

- Quick prototyping
- Existing ChangeNotifier code migrate করতে

⚠️ নতুন প্রজেক্টে StateNotifierProvider বা NotifierProvider ব্যবহার করুন

[ChangeNotifierProvider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/change_notifier_provider/change_notifier_provider.dart)

---

### 7️⃣ `NotifierProvider` কী এবং কেন?
NotifierProvider হলো Riverpod 2.0+ এর modern approach। এটি StateNotifierProvider এর চেয়ে বেশি flexible।

**কখন ব্যবহার করবে?**

- Modern Riverpod projects
- Complex state with multiple methods
- Better type safety
- Easier testing


[NotifierProvider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/notifier_provider/notifier_provider.dart)

---

### 8️⃣ `AsyncNotifierProvider` কী এবং কেন?
AsyncNotifierProvider asynchronous state management এর জন্য modern solution।

**কখন ব্যবহার করবে?**

- API calls with state management
- Database operations with loading/error states
- Complex async workflows
- Pagination


[AsyncNotifierProvider Code Example দেখতে এখানে ক্লিক করুন](lib/app/all_provider/async_notifier_provider/async_notifier_provider.dart)

---

**ref এর ব্যবহার**
ref হলো Riverpod এর সবচেয়ে গুরুত্বপূর্ণ object। এর মাধ্যমে provider এর সাথে interact করা হয়।

ref.watch() - Reactive Updates
কখন ব্যবহার করবেন?

- UI তে value দেখাতে
- Automatic rebuild চাইলে
- Provider এর পরিবর্তন track করতে

```dart
class MyWidget extends ConsumerWidget {
@override
Widget build(BuildContext context, WidgetRef ref) {
// watch করলে value change হলে rebuild হবে
final count = ref.watch(counterProvider);

    return Text('Count: $count');
}
}
```

**ref.read()** - One-time Read
কখন ব্যবহার করবেন?

✅ Event handler এ (onPressed, onChanged)
✅ One-time value পড়তে
✅ Method call করতে

```dart
ElevatedButton(
onPressed: () {
// read করলে rebuild হবে না
ref.read(counterProvider.notifier).state++;
},
child: Text('Increment'),
)
```
**ref.listen()** - Side Effects
কখন ব্যবহার করবেন?

✅ Snackbar দেখাতে
✅ Navigation করতে
✅ Dialog show করতে

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for changes
    ref.listen(authProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Logged in successfully!')),
            );
          }
        },
        loading: () {},
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        },
      );
    });

    return Container();
  }
}
```

**ref.invalidate()** - Refresh Provider

```dart
ElevatedButton(
onPressed: () {
// Provider refresh করবে
ref.invalidate(userProvider);
},
child: Text('Refresh'),
)
```
  **Copywith method**
  **select()**
  **autoDispose**
  **ConsumerWidget**
  **ConsumerStatefulWidget**
  


Important Repository please check masum
* https://github.com/Uuttssaavv/flutter-clean-architecture-riverpod
* https://dev.to/ssoad/flutter-riverpod-clean-architecture-the-ultimate-production-ready-template-for-scalable-apps-gdh
* https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/
