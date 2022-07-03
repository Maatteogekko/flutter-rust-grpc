import 'dart:io';

import 'package:client/proto/hello_world.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

final channelProvider = Provider<GrpcOrGrpcWebClientChannel>((ref) {
  return GrpcOrGrpcWebClientChannel.toSingleEndpoint(
    host: Platform.isAndroid ? '10.0.2.2' : 'localhost',
    port: 50051,
    transportSecure: false,
  );
});

final greeterClientProvider = Provider<GreeterClient>((ref) {
  return GreeterClient(ref.watch(channelProvider));
});
