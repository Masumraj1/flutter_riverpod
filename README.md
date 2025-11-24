# riverpod_prectice

# ProviderScope
#### ProviderScope না দিলে Riverpod একদম কাজ করবে না।
#### কারণ ProviderScope হচ্ছে একটা গ্লোবাল container যেখানে সব provider গুলো store হয়।
#### সাধারনত main.dart এ wrap করে দিতে হয়:

# Provider Types শিখা

#### StateProvider → simple value/state store
#### FutureProvider → async data load (যেমন API call)
#### StreamProvider → live data stream
#### StateNotifierProvider → complex state management (counter, list, model)

# ref.watch, ref.read, ref.listen
#### ref.watch() → UI কে reactive করে (value change হলে rebuild হবে)
#### ref.read() → শুধু value নেবে, rebuild করবে না (onTap, onPressed এ ভালো use হয়)
#### ref.listen() → value change observe করবে (SnackBar, Navigation, Logging এর জন্য)
#### NotifierProvider (v2) → Riverpod v2 তে নতুন system (OOP feel দেয়)

### Riverpod নিজে route system দেয় না ❌ — কারণ Riverpod মূলত state management library।

Riverpod মূলত cache-এর মতোই state ধরে রাখে।
তুমি যদি autoDispose ব্যবহার না করো, তাহলে provider-এর state memory তে থাকবে যতক্ষণ না:

ProviderScope destroy হয়

তুমি manually invalidate করো

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
