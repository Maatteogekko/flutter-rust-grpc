import 'package:client/services/greeter/greeter_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message = ref.watch(greeterNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Say hello'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TextField(
                  controller: _controller,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(greeterNotifierProvider.notifier).sayHello(_controller.text),
                      child: const Text('Send'),
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(greeterNotifierProvider.notifier).clear();
                        _controller.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: message == null
                  ? Text('Who do you want do greet?', key: ValueKey(message))
                  : message.when(
                      data: ((data) => Text(data, key: ValueKey(message))),
                      error: (e, st) => SelectableText(
                        e.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                      loading: () => const CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
