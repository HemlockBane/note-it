class Note {
  Note(
      {this.title = 'A note on colonisation',
      this.content =
          'Colonial Masters decided to colonise. What the hell am I saying?',
      this.date = '21st Nov 2020 at 21:15',
      this.tagName = 'Exam'});

  final String title;
  final String content;
  final String date;
  final String tagName;
}

List<Note> getDummyNotes() {
  return List.generate(10, (_) => Note());
}
