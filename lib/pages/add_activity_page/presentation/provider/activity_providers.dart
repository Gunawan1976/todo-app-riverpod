import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/pages/add_activity_page/data/implements/add_activity_implements.dart';
import '../../data/data_sources/local_source.dart';
import '../../domain/entities/add_activity_entity.dart';
import '../../domain/repositories/add_activity_repository.dart';
import '../controller/activity_notifier.dart';

// 1. Provider untuk Local Database (Singleton)
final localDatabaseProvider = Provider((ref) => LocalDatabase());

// 2. Provider untuk Repository (DI)
final activityRepositoryProvider = Provider<AddActivityRepository>((ref) {
  final db = ref.watch(localDatabaseProvider);
  return AddActivityRepositoryImplements(db);
});


// 3. Provider untuk STATE utama (Menggantikan ActivityBloc)
final activityListProvider = AsyncNotifierProvider<ActivityNotifier, List<AddActivityEntity>>(() {
  return ActivityNotifier();
});

DateTime _normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

final todayListProvider = Provider<List<AddActivityEntity>>((ref) {
  final asyncActivities = ref.watch(activityListProvider);
  if (asyncActivities.isLoading || asyncActivities.hasError) return [];

  final allActivities = asyncActivities.value!;
  // Tanggal dasar (Hari ini jam 00:00:00)
  final todayNormalized = _normalizeDate(DateTime.now());

  return allActivities.where((note) {
    // 1. Normalisasi due date task
    final noteDateNormalized = _normalizeDate(note.dueDate!);

    // 2. Cek apakah tanggalnya SAMA PERSIS dengan hari ini
    return noteDateNormalized.isAtSameMomentAs(todayNormalized);
  }).toList();
});

final upcomingListProvider = Provider<List<AddActivityEntity>>((ref) {
  final asyncActivities = ref.watch(activityListProvider);
  if (asyncActivities.isLoading || asyncActivities.hasError) return [];

  final allActivities = asyncActivities.value!;
  // Tanggal dasar (Tengah malam hari ini)
  final todayNormalized = _normalizeDate(DateTime.now());

  return allActivities.where((note) {
    // 1. Normalisasi due date task
    final noteDateNormalized = _normalizeDate(note.dueDate!);

    // 2. Cek apakah tanggalnya berada di MASA DEPAN (besok dan seterusnya)
    return noteDateNormalized.isAfter(todayNormalized);
  }).toList();

  // Catatan: Hapus blok if (kDebugMode) di production code.
});

// 5. Provider Filter: History (Masa Lalu)
final historyListProvider = Provider<List<AddActivityEntity>>((ref) {
  final asyncActivities = ref.watch(activityListProvider);
  if (asyncActivities.isLoading || asyncActivities.hasError) return [];

  final allActivities = asyncActivities.value!;
  // Tanggal dasar (Tengah malam hari ini)
  final todayNormalized = _normalizeDate(DateTime.now());

  return allActivities.where((note) {
    // 1. Normalisasi due date task
    final noteDateNormalized = _normalizeDate(note.dueDate!);

    // 2. Cek apakah tanggalnya berada di MASA LALU (kemarin dan sebelumnya)
    return noteDateNormalized.isBefore(todayNormalized);
  }).toList();
});