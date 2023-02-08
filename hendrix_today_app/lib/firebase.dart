import 'package:hendrix_today_app/Objects/AppState.dart';
import 'package:hendrix_today_app/Objects/Event.dart';

// if this function is useful, move it to AppState,
// if not, delete

// Future getRef() async {
//   final ref = db.collection("eventsListed").doc("event1").withConverter(
//         fromFirestore: Event.fromFirestore,
//         toFirestore: (Event event, _) => event.toFirestore(),
//       );
//   final docSnap = await ref.get();
//   final event = docSnap.data(); // Convert to Event object
//   if (event != null) {
//     return (event);
//   } else {
//     return ("No such document.");
//   }
// }
