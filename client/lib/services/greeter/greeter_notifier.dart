import 'package:client/proto/hello_world.pbgrpc.dart';
import 'package:client/services/remote_server/providers.dart';
import 'package:riverbloc/riverbloc.dart';

final greeterNotifierProvider = BlocProvider<GreeterNotifier, AsyncValue<String>?>(
  (ref) => GreeterNotifier(ref.watch(greeterClientProvider)),
);

class GreeterNotifier extends Cubit<AsyncValue<String>?> {
  final GreeterClient _client;

  GreeterNotifier(this._client) : super(null);

  Future<void> sayHello(String? name) async {
    emit(const AsyncValue.loading());

    final request = HelloRequest(name: name);

    emit(
      await AsyncValue.guard(() async {
        final response = await _client.sayHello(request);

        return response.message;
      }),
    );
  }
}
