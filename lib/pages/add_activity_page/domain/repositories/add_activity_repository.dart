
import '../entities/add_activity_entity.dart';

abstract class AddActivityRepository {
  Future<List<AddActivityEntity>> getNotes();
  Future<void> addNote(AddActivityEntity note);
  Future<void> updateNote(AddActivityEntity note);
  Future<void> deleteNote(int id);
}