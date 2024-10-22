String FormatTime(int secondsElapsed) {
  int minutes = secondsElapsed ~/ 60;
  int seconds = secondsElapsed % 60;
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');
  return '$minutesStr:$secondsStr';
}
