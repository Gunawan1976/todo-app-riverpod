import '../../domain/entities/add_activity_entity.dart';

class AddActivityModel extends AddActivityEntity{
  final int? id;
  final String? title;
  final String? description;
  final String? descriptionOptional;
  final DateTime? dueDate;

  AddActivityModel({this.id, this.title, this.description, this.descriptionOptional, this.dueDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'descriptionOptional': descriptionOptional,
      'dueDate':dueDate?.toIso8601String()
    };
  }

  // Mengubah Map menjadi Note (saat mengambil dari SQL)
  factory AddActivityModel.fromMap(Map<String, dynamic> map) {
    return AddActivityModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      descriptionOptional: map['descriptionOptional'],
      dueDate: DateTime.parse(map['dueDate'])
    );
  }

  factory AddActivityModel.fromEntity(AddActivityEntity note) {
    return AddActivityModel(
        id: note.id,
        title: note.title,
        description: note.description,
        descriptionOptional: note.descriptionOptional,
        dueDate: note.dueDate
    );
  }
}