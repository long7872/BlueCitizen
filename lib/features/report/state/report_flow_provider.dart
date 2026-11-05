import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ReportType { pollution, species }

class ReportFlowNotifier extends Notifier<ReportType?> {
  @override
  ReportType? build() => null;

  void select(ReportType type) {
    state = type;
  }

  void reset() {
    state = null;
  }
}

final reportFlowProvider =
    NotifierProvider.autoDispose<ReportFlowNotifier, ReportType?>(
      ReportFlowNotifier.new,
    );
