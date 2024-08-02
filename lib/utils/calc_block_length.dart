double calcBlockLength(currentBlock) {
  // Yksiköt tulee muuttaa toisiaan vastaaviksi, am / pm
  // Jos toinen on am ja toinen pm, niin tulee laskentavirhe

  int formatTimes(time) {
    // split to time [0] and am/pm [1] part
    List<String> timeParts = time.split(' ');
    // split to hours and minutes
    List<String> hoursAndMinutes = timeParts[0].split(':');
    int hours = int.parse(hoursAndMinutes[0]);
    int minutes = int.parse(hoursAndMinutes[1]);

    // Tranform all to 24 hour format
    if (timeParts[1] == 'PM' && hours != 12) {
      hours += 12;
    } else if (timeParts[1] == 'AM' && hours == 12) {
      hours = 0;
    }

    // turn all to same units in minutes and return
    int totalMinutes = hours * 60 + minutes;

    return totalMinutes;
  }

  // calculate the difference and change to double
  double timeDifference = formatTimes(currentBlock["endTime"]) -
      formatTimes(currentBlock["startTime"]).toDouble();

  return timeDifference;
}
