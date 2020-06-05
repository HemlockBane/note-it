import 'package:date_format/date_format.dart';

class Note {
  int id = 0;
  String title = '';
  String content = '';
  String dateCreated = DateTime.now().toIso8601String();
  String tagName = '';

  // bool get isNew => this.title.isEmpty && this.content.isEmpty;

  Note();

  Note.dummy(
      {this.id = 0,
      this.title = 'A note on colonisation',
      this.content =
          'Colonial Masters decided to colonise. What the hell am I saying?',
      this.tagName = ''})
      : this.dateCreated = DateTime.now().toIso8601String();

  Note.fromMap(Map json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    // id will be auto generated in the db
    map['title'] = title;
    map['content'] = content;
    map['date_created'] = dateCreated;
    return map;
  }

  @override
  String toString() {
    return ''
        'id - $id, '
        'title - $title, '
        'date_created - $dateCreated, '
        'content - $content, ';
  }
}

List<Note> getDummyNotes() {
  return List.generate(0, (_) => Note.dummy());
}
