import 'package:date_format/date_format.dart';

class Note {
  String title = '';
  String content = '';
  String dateCreated = DateTime.now().toIso8601String();
  String tagName = '';

  bool get isNew => this.title.isEmpty && this.content.isEmpty;

  Note();

  Note.dummy(
      {this.title = 'A note on colonisation',
      this.content =
          'Colonial Masters decided to colonise. What the hell am I saying?',
      this.tagName = 'Exam'})
      : this.dateCreated = DateTime.now().toIso8601String();

}

List<Note> getDummyNotes() {
  return List.generate(10, (_) => Note.dummy());
}
