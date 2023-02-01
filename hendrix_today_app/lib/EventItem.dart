// ignore_for_file: non_constant_identifier_names

String title = '';
String description = '';
String event_date = '';
String begin_post = '';
String final_post = '';

class EventItem {
  final String title;
  final String description;
  final String event_date_begin;
  final String begin_post;
  final String final_post;
  final String event_date_end;
  final String event_time;

  EventItem(
      {required this.title,
      required this.description,
      required this.event_date_begin,
      required this.event_date_end,
      required this.event_time,
      required this.begin_post,
      required this.final_post});

  List date_split(String parts) {
    int idx = begin_post.indexOf("/");
    List split = [
      parts.substring(0, idx).trim(),
      parts.substring(idx + 1).trim()
    ];
    return split;
  }
}
