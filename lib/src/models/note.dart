import 'package:date_format/date_format.dart';

class Note {
  int id = 0;
  String title = '';
  String content = '';
  String dateCreated = DateTime.now().toIso8601String();
  String dateLastModified = DateTime.now().toIso8601String();
  String tagName = '';

  // bool get isNew => this.title.isEmpty && this.content.isEmpty;

  // We're initialising the date outside the constructor brackets because
  // The default value of an optional parameter must be constant.
  // See error: dartnon_constant_default_value

  Note();

  Note.dummy(
      {this.id = 0,
      this.title = 'A note on colonisation',
      this.content =
          'Colonial Masters decided to colonise. What the hell am I saying?',
      this.tagName = ''})
      : this.dateCreated = DateTime.now().toIso8601String(),
        this.dateLastModified = DateTime.now().toIso8601String();

  Note.copyOf(Note note) {
    id = note.id;
    title = note.title;
    content = note.content;
    dateCreated = note.dateCreated;
    dateLastModified = note.dateLastModified;
    tagName = note.tagName;
  }

  Note.fromMap(Map json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    dateCreated = json['date_created'];
    dateLastModified = json['date_last_modified'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    // id will be auto generated in the db
    map['title'] = title;
    map['content'] = content;
    map['date_created'] = dateCreated;
    map['date_last_modified'] = dateLastModified;
    return map;
  }

  @override
  String toString() {
    return ''
        // 'id - $id, '
        'title - $title, '
        'content - $content, '
        'date_created - $dateCreated, '
        'date_last_modified - $dateLastModified, ';
  }
}

List<Note> getDummyNotes() {
  return List.generate(0, (_) => Note.dummy());
}
