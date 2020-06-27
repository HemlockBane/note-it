import 'package:date_format/date_format.dart';

class Note {
  int id = 0;
  String title = '';
  String content = '';
  String dateCreated = DateTime.now().toIso8601String();
  String dateLastModified = DateTime.now().toIso8601String();
  bool isArchived = false;
  String tagName = '';

  bool _mapIntegerToBool(int value) => value == 1 ? true : false;

  // bool get isNew => this.title.isEmpty && this.content.isEmpty;

  // We're initialising the date outside the constructor brackets because
  // The default value of an optional parameter must be constant.
  // See error: dartnon_constant_default_value

  Note();

  Note.from(
      {this.id,
      this.title,
      this.content,
      this.dateCreated,
      this.dateLastModified,
      this.isArchived});

  Note.dummy(
      {this.id = 0,
      this.title = 'A note on colonisation',
      this.content =
          'Colonial Masters decided to colonise. What the hell am I saying?',
      this.tagName = '',
      this.isArchived = false})
      : this.dateCreated = DateTime.now().toIso8601String(),
        this.dateLastModified = DateTime.now().toIso8601String();

  Note.copyOf(Note note) {
    id = note.id;
    title = note.title;
    content = note.content;
    dateCreated = note.dateCreated;
    dateLastModified = note.dateLastModified;
    tagName = note.tagName;
    isArchived = note.isArchived;
  }

  Note copyWith({bool isArchived}) {
    return Note.from(
        id: this.id,
        title: this.title,
        content: this.content,
        dateCreated: this.dateCreated,
        dateLastModified: this.dateLastModified,
        isArchived: isArchived ?? this.isArchived);
  }

  Note.fromMap(Map json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    dateCreated = json['date_created'];
    dateLastModified = json['date_last_modified'];
    isArchived = _mapIntegerToBool(json['is_archived']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    // id will be auto generated in the db
    map['title'] = title;
    map['content'] = content;
    map['date_created'] = dateCreated;
    map['date_last_modified'] = dateLastModified;
    map['is_archived'] = isArchived ? 1 : 0;
    return map;
  }

  @override
  String toString() {
    return ''
        // 'id - $id, '
        'title - $title, '
        'content - $content, '
        'date_created - $dateCreated, '
        'date_last_modified - $dateLastModified, '
        'is_archived - $isArchived, ';
  }
}

List<Note> getDummyNotes() {
  return List.generate(0, (_) => Note.dummy());
}
