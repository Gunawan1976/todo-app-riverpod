import 'package:todo_app/pages/add_activity_page/data/data_sources/local_source.dart';
import 'package:todo_app/pages/add_activity_page/domain/entities/add_activity_entity.dart';
import 'package:todo_app/pages/add_activity_page/domain/repositories/add_activity_repository.dart';

import '../models/add_activity_model.dart';

class AddActivityRepositoryImplements extends AddActivityRepository{
  final LocalDatabase db;

  AddActivityRepositoryImplements(this.db);

  @override
  Future<void> addNote(AddActivityEntity note)async {
    await db.insert(AddActivityModel.fromEntity(note));
  }

  @override
  Future<void> deleteNote(int id) async{
    await db.delete(id);
  }

  @override
  Future<List<AddActivityEntity>> getNotes() async{
    final result = await db.getAll();
    return result;
  }

  @override
  Future<void> updateNote(AddActivityEntity note)async {
    await db.update(AddActivityModel.fromEntity(note));
  }

}