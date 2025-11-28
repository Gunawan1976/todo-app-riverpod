import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/add_activity_entity.dart';
import '../provider/activity_providers.dart';

class ActivityNotifier extends AsyncNotifier<List<AddActivityEntity>> {

  // Fungsi utama untuk memuat data (Dipanggil Riverpod saat pertama kali diakses)
  @override
  Future<List<AddActivityEntity>> build() async {
    final repository = ref.read(activityRepositoryProvider);
    // Secara otomatis akan menjadi AsyncLoading saat berjalan dan AsyncData jika sukses
    return repository.getNotes();
  }

  // --- FUNGSI CRUD (Menggantikan Events) ---

  // CREATE: Tambah data
  Future<void> addNote(AddActivityEntity activity) async {
    final repository = ref.read(activityRepositoryProvider);
    state = const AsyncValue.loading(); // Tampilkan loading saat proses
    await AsyncValue.guard(() async {
      await repository.addNote(activity);
    });
    ref.invalidateSelf(); // Minta Riverpod memuat ulang data (memanggil build())
  }

  // UPDATE: Update data
  Future<void> updateNote(AddActivityEntity activity) async {
    final repository = ref.read(activityRepositoryProvider);
    state = const AsyncValue.loading();
    await AsyncValue.guard(() async {
      await repository.updateNote(activity);
    });
    ref.invalidateSelf(); // Muat ulang
  }

  // DELETE: Hapus data
  Future<void> deleteNote(int id) async {
    final repository = ref.read(activityRepositoryProvider);
    // Cara cepat: update state tanpa loading (jika ingin optimis UI)
    await repository.deleteNote(id);

    // Atau cara aman: muat ulang
    ref.invalidateSelf();
  }
}