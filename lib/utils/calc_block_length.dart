double calcBlockLength(currentBlock) {
  List<String> startParts = currentBlock["startTime"].split(':');
  List<String> endParts = currentBlock["endTime"].split(':');
  if (endParts.last.length == 5 && startParts.last.length == 5) {
    endParts[1] = endParts[1].substring(0, 3);
    startParts[1] = startParts[1].substring(0, 3);
  }

  int startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
  int endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);

  double timeDifference = (endMinutes - startMinutes) / 2;

  return timeDifference;
}
