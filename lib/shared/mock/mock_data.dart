import '../models/area_stats.dart';
import '../models/campaign.dart';
import '../models/cleanup_event.dart';
import '../models/pollution_report.dart';
import '../models/severity.dart';
import '../models/species_sighting.dart';
import '../models/user_profile.dart';

/// Centralized sample data shared by all BlueCitizen feature modules.
///
/// Feature screens should read mutable data through providers in
/// `mock_store.dart` so that updates made by one feature are visible to others.
class MockData {
  MockData._();

  static final List<PollutionReport>
  reports = List<PollutionReport>.unmodifiable([
    PollutionReport(
      id: 'report_001',
      title: 'Plastic bottles near the shoreline',
      description:
          'Several plastic bottles and food wrappers were found along the beach.',
      lat: 20.9584,
      lng: 107.0657,
      severity: Severity.medium,
      wasteType: WasteType.plastic,
      status: ReportStatus.pending,
      photoPaths: const [
        'mock/reports/report_001_1.jpg',
        'mock/reports/report_001_2.jpg',
      ],
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    PollutionReport(
      id: 'report_002',
      title: 'Abandoned fishing net',
      description:
          'A section of fishing net is tangled around rocks near the water.',
      lat: 20.9518,
      lng: 107.0732,
      severity: Severity.high,
      wasteType: WasteType.fishingGear,
      status: ReportStatus.approved,
      photoPaths: const ['mock/reports/report_002_1.jpg'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PollutionReport(
      id: 'report_003',
      title: 'Glass and metal waste',
      description:
          'Small pieces of glass and metal waste were spotted near a public pier.',
      lat: 20.9641,
      lng: 107.0588,
      severity: Severity.low,
      wasteType: WasteType.glass,
      status: ReportStatus.inProgress,
      photoPaths: const [],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PollutionReport(
      id: 'report_004',
      title: 'Mixed waste accumulation',
      description:
          'A pile of mixed household waste has accumulated close to the coast.',
      lat: 20.9449,
      lng: 107.0804,
      severity: Severity.medium,
      wasteType: WasteType.other,
      status: ReportStatus.resolved,
      photoPaths: const ['mock/reports/report_004_1.jpg'],
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ]);

  static final List<CleanupEvent> events = List<CleanupEvent>.unmodifiable([
    CleanupEvent(
      id: 'event_001',
      title: 'Ha Long Bay Weekend Cleanup',
      locationName: 'Bai Chay Beach, Ha Long',
      lat: 20.9584,
      lng: 107.0657,
      startsAt: DateTime.now().add(const Duration(days: 3)),
      capacity: 50,
      joined: 24,
      isJoined: false,
      checklist: const [
        'Reusable water bottle',
        'Hat and sunscreen',
        'Reusable gloves',
      ],
    ),
    CleanupEvent(
      id: 'event_002',
      title: 'Coastal Waste Sorting Day',
      locationName: 'Hon Gai Waterfront, Ha Long',
      lat: 20.9512,
      lng: 107.0745,
      startsAt: DateTime.now().add(const Duration(days: 7)),
      capacity: 35,
      joined: 35,
      isJoined: false,
      checklist: const [
        'Closed-toe shoes',
        'Reusable water bottle',
        'Sun protection',
      ],
    ),
    CleanupEvent(
      id: 'event_003',
      title: 'Community Marine Cleanup',
      locationName: 'Tuan Chau Island, Ha Long',
      lat: 20.9256,
      lng: 106.9998,
      startsAt: DateTime.now().add(const Duration(days: 10)),
      capacity: 40,
      joined: 18,
      isJoined: true,
      checklist: const ['Reusable gloves', 'Water bottle', 'Small towel'],
    ),
  ]);

  static final List<SpeciesSighting>
  speciesSightings = List<SpeciesSighting>.unmodifiable([
    SpeciesSighting(
      id: 'sighting_001',
      speciesName: 'Green sea turtle',
      lat: 20.9120,
      lng: 107.1800,
      note: 'Observed swimming close to the reef.',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    SpeciesSighting(
      id: 'sighting_002',
      speciesName: 'Indo-Pacific humpback dolphin',
      lat: 20.8875,
      lng: 107.1450,
      note:
          'A small group was seen offshore. Observation made from a safe distance.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SpeciesSighting(
      id: 'sighting_003',
      speciesName: 'Blacktip reef shark',
      lat: 20.9014,
      lng: 107.1126,
      note: 'One individual was observed near the reef edge.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ]);

  static final List<Campaign> campaigns = List<Campaign>.unmodifiable([
    const Campaign(
      id: 'campaign_001',
      title: 'Restore Our Coastline',
      organization: 'BlueCitizen Community',
      goalAmount: 50000000,
      raisedAmount: 18500000,
    ),
    const Campaign(
      id: 'campaign_002',
      title: 'Protect Marine Wildlife',
      organization: 'Ocean Guardians',
      goalAmount: 80000000,
      raisedAmount: 42600000,
    ),
  ]);

  static const UserProfile currentUser = UserProfile(
    id: 'user_001',
    name: 'Minh',
    level: 3,
    points: 420,
    badges: ['first_report', 'cleanup_helper', 'ocean_watcher'],
  );

  static final List<AreaStats> areaStats = List<AreaStats>.unmodifiable([
    const AreaStats(
      id: 'area_001',
      name: 'Ha Long Bay',
      wasteKg: 125.5,
      reportCount: 48,
      cleanScore: 72.5,
    ),
    const AreaStats(
      id: 'area_002',
      name: 'Bai Chay Beach',
      wasteKg: 68.2,
      reportCount: 21,
      cleanScore: 81.0,
    ),
    const AreaStats(
      id: 'area_003',
      name: 'Tuan Chau Island',
      wasteKg: 94.7,
      reportCount: 32,
      cleanScore: 66.5,
    ),
  ]);
}
