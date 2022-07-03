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
        padding: const EdgeInsets.all(264),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TextField(
                  controller: _controller,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(greeterNotifierProvider.notifier).sayHello(_controller.text),
                  child: const Text('Send'),
                ),
              ],
            ),
            if (message == null)
              const Text('Who do you want do greet?')
            else
              message.when(
                data: ((data) => Text(data)),
                error: (e, st) => SelectableText(
                  e.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                loading: () => const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
