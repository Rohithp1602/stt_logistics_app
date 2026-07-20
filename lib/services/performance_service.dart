import 'package:firebase_performance/firebase_performance.dart';
import 'package:get/get.dart';

/// Firebase Performance custom-trace helper.
class PerformanceService extends GetxService {
  PerformanceService({bool enabled = true}) : _enabled = enabled;

  final bool _enabled;

  FirebasePerformance? get _perf {
    if (!_enabled) return null;
    return FirebasePerformance.instance;
  }

  Future<Trace?> startTrace(String name) async {
    try {
      final perf = _perf;
      if (perf == null) return null;
      final trace = perf.newTrace(name);
      await trace.start();
      return trace;
    } catch (_) {
      return null;
    }
  }

  Future<void> stopTrace(Trace? trace) async {
    if (trace == null) return;
    try {
      await trace.stop();
    } catch (_) {}
  }
}
