import 'package:get/get.dart';
import 'package:todo_app/pages/add_activity_page/domain/entities/add_activity_entity.dart';
import 'package:todo_app/pages/add_activity_page/domain/repositories/add_activity_repository.dart';

class AddActivityController extends GetxController{
  final AddActivityRepository repository;

  AddActivityController(this.repository);

  // State (Reactive List)
  var notes = <AddActivityEntity>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  // READ
  void fetchNotes() async {
    isLoading.value = true;
    try {
      var result = await repository.getNotes();
      notes.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  // CREATE
  void addNote({required String title,required String desc,required DateTime dueDate}) async {
    await repository.addNote(AddActivityEntity(title: title, description: desc,dueDate: dueDate,descriptionOptional: ""));
    fetchNotes(); // Refresh list
  }

  // UPDATE
  void updateNote(int id, String title, String desc) async {
    await repository.updateNote(AddActivityEntity(id: id, title: title, description: desc));
    fetchNotes();
  }

  // DELETE
  void deleteNote(int id) async {
    await repository.deleteNote(id);
    fetchNotes();
  }
}