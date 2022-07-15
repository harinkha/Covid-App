class Task {
  String title;
  String endTime;
  String startTime;
  String note;
  String date;
  bool isCompleted;
  String repeat;

  Task(this.title, this.date, this.endTime, this.isCompleted, this.note,
      this.repeat, this.startTime);

  Map<String, dynamic> toJson() => {
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
        'note': note,
        'date': date,
        'isCompleted': isCompleted,
        'repeat': repeat
      };
}
