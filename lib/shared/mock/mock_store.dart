import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/area_stats.dart';
import '../models/campaign.dart';
import '../models/cleanup_event.dart';
import '../models/pollution_report.dart';
import '../models/species_sighting.dart';
import '../models/user_profile.dart';
import 'mock_data.dart';

/// Shared in-memory pollution-report store.
class ReportsNotifier extends Notifier<List<PollutionReport>> {
  @override
  List<PollutionReport> build() {
    return List<PollutionReport>.unmodifiable(MockData.reports);
  }

  /// Adds a report to the shared collection.
  ///
  /// New reports are inserted first so recent submissions appear at the top.
  /// Throws [ArgumentError] if another report already uses the same ID.
  void add(PollutionReport report) {
    if (state.any((item) => item.id == report.id)) {
      throw ArgumentError.value(
        report.id,
        'report.id',
        'A report with this ID already exists.',
      );
    }

    state = List<PollutionReport>.unmodifiable([report, ...state]);
  }

  /// Changes a report's status.
  ///
  /// Returns false when no report with [id] exists.
  bool setStatus(String id, ReportStatus status) {
    final exists = state.any((report) => report.id == id);
    if (!exists) return false;

    state = List<PollutionReport>.unmodifiable(
      state.map(
        (report) => report.id == id ? report.copyWith(status: status) : report,
      ),
    );
    return true;
  }

  /// Replaces a report with the same ID, or adds it when not found.
  void upsert(PollutionReport report) {
    final exists = state.any((item) => item.id == report.id);
    if (!exists) {
      add(report);
      return;
    }

    state = List<PollutionReport>.unmodifiable(
      state.map((item) => item.id == report.id ? report : item),
    );
  }

  /// Removes a report by ID.
  void remove(String id) {
    state = List<PollutionReport>.unmodifiable(
      state.where((report) => report.id != id),
    );
  }
}

final reportsProvider =
    NotifierProvider<ReportsNotifier, List<PollutionReport>>(
      ReportsNotifier.new,
    );

/// Shared in-memory cleanup-event store.
class EventsNotifier extends Notifier<List<CleanupEvent>> {
  @override
  List<CleanupEvent> build() {
    return List<CleanupEvent>.unmodifiable(MockData.events);
  }

  /// Toggles the current user's participation in an event.
  ///
  /// Returns false if the event does not exist, or if the current user tries
  /// to join an event that has already reached capacity.
  bool toggleJoin(String id) {
    final index = state.indexWhere((event) => event.id == id);
    if (index == -1) return false;

    final event = state[index];

    if (!event.isJoined && event.joined >= event.capacity) {
      return false;
    }

    final updatedEvent = event.isJoined
        ? event.copyWith(
            isJoined: false,
            joined: event.joined > 0 ? event.joined - 1 : 0,
          )
        : event.copyWith(isJoined: true, joined: event.joined + 1);

    final updatedEvents = [...state];
    updatedEvents[index] = updatedEvent;
    state = List<CleanupEvent>.unmodifiable(updatedEvents);
    return true;
  }

  /// Adds an event. Duplicate IDs are rejected.
  void add(CleanupEvent event) {
    if (state.any((item) => item.id == event.id)) {
      throw ArgumentError.value(
        event.id,
        'event.id',
        'An event with this ID already exists.',
      );
    }

    state = List<CleanupEvent>.unmodifiable([event, ...state]);
  }

  /// Replaces an event with the same ID, or adds it when not found.
  void upsert(CleanupEvent event) {
    final exists = state.any((item) => item.id == event.id);
    if (!exists) {
      add(event);
      return;
    }

    state = List<CleanupEvent>.unmodifiable(
      state.map((item) => item.id == event.id ? event : item),
    );
  }
}

final eventsProvider = NotifierProvider<EventsNotifier, List<CleanupEvent>>(
  EventsNotifier.new,
);

/// Shared in-memory marine-species-sighting store.
class SpeciesSightingsNotifier extends Notifier<List<SpeciesSighting>> {
  @override
  List<SpeciesSighting> build() {
    return List<SpeciesSighting>.unmodifiable(MockData.speciesSightings);
  }

  void add(SpeciesSighting sighting) {
    if (state.any((item) => item.id == sighting.id)) {
      throw ArgumentError.value(
        sighting.id,
        'sighting.id',
        'A sighting with this ID already exists.',
      );
    }

    state = List<SpeciesSighting>.unmodifiable([sighting, ...state]);
  }

  void remove(String id) {
    state = List<SpeciesSighting>.unmodifiable(
      state.where((sighting) => sighting.id != id),
    );
  }
}

final speciesSightingsProvider =
    NotifierProvider<SpeciesSightingsNotifier, List<SpeciesSighting>>(
      SpeciesSightingsNotifier.new,
    );

/// Shared in-memory fundraising-campaign store.
class CampaignsNotifier extends Notifier<List<Campaign>> {
  @override
  List<Campaign> build() {
    return List<Campaign>.unmodifiable(MockData.campaigns);
  }

  void add(Campaign campaign) {
    if (state.any((item) => item.id == campaign.id)) {
      throw ArgumentError.value(
        campaign.id,
        'campaign.id',
        'A campaign with this ID already exists.',
      );
    }

    state = List<Campaign>.unmodifiable([campaign, ...state]);
  }

  /// Updates the campaign's raised amount.
  ///
  /// Returns false when no campaign with [id] exists.
  bool setRaisedAmount(String id, double amount) {
    if (amount < 0) {
      throw ArgumentError.value(amount, 'amount', 'Amount cannot be negative.');
    }

    final exists = state.any((campaign) => campaign.id == id);
    if (!exists) return false;

    state = List<Campaign>.unmodifiable(
      state.map(
        (campaign) => campaign.id == id
            ? campaign.copyWith(raisedAmount: amount)
            : campaign,
      ),
    );
    return true;
  }
}

final campaignsProvider = NotifierProvider<CampaignsNotifier, List<Campaign>>(
  CampaignsNotifier.new,
);

/// Read-only provider for the demo user's profile.
final currentUserProvider = Provider<UserProfile>((ref) {
  return MockData.currentUser;
});

/// Read-only provider for static environmental statistics.
final areaStatsProvider = Provider<List<AreaStats>>((ref) {
  return MockData.areaStats;
});
