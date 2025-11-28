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

// 4. Provider Filter: Upcoming (Hari ini & Masa Depan)
final upcomingListProvider = Provider<List<AddActivityEntity>>((ref) {
  // Amati (watch) state utama
  final asyncActivities = ref.watch(activityListProvider);

  // Jika masih loading/error, kembalikan list kosong
  if (asyncActivities.isLoading || asyncActivities.hasError) {
    return [];
  }

  // Jika data sudah ada, terapkan filtering
  final allActivities = asyncActivities.value!;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  return allActivities.where((note) {
    return note.dueDate!.isAtSameMomentAs(today) || note.dueDate!.isAfter(today);
  }).toList();
});

// 5. Provider Filter: History (Masa Lalu)
final historyListProvider = Provider<List<AddActivityEntity>>((ref) {
  // Hanya perlu mengamati (watch) list utama
  final asyncActivities = ref.watch(activityListProvider);

  if (asyncActivities.isLoading || asyncActivities.hasError) {
    return [];
  }

  final allActivities = asyncActivities.value!;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  return allActivities.where((note) {
    return note.dueDate!.isBefore(today);
  }).toList();
});