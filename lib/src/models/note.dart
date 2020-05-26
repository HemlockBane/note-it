class Note {
  String title = '';
  String content = '';
  String date = DateTime.now().toIso8601String();
  String tagName = '';

  bool get isEmpty => this.title.isEmpty && this.content.isEmpty;

  Note();

  Note.dummy(
      {this.title = 'A note on colonisation',
      this.content =
          'Colonial Masters decided to colonise. What the hell am I saying?',
      this.tagName = 'Exam'})
      : this.date = DateTime.now().toIso8601String();
}

List<Note> getDummyNotes() {
  return List.generate(10, (_) => Note.dummy());
}
