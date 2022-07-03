import 'package:client/proto/hello_world.pbgrpc.dart';
import 'package:client/services/remote_server/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sayHelloProvider = FutureProvider.family<HelloReply, String?>(
  (ref, message) async {
    final client = ref.watch(greeterClientProvider);
    final request = HelloRequest(name: message);

    return client.sayHello(request);
  },
);

class AppWidget extends ConsumerStatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends ConsumerState<AppWidget> {
  final controller = TextEditingController(text: 'from Flutter');

  @override
  Widget build(BuildContext context) {
    final message = ref.watch(sayHelloProvider(controller.text));

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const TextField(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
            message.when(
              data: ((data) => Text(data.message)),
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
