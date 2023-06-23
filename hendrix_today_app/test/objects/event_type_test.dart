import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/event_type.dart';

void main() {
  test('EventTypes can be read from strings', () {
    expect(EventType.fromString("aselifjWAE"), null,
      reason: "An invalid string should not be translatable into an EventType");
    expect(EventType.fromString(null), null,
      reason: "A null string should not be translatable into an EventType");
    expect(EventType.fromString("eVeNt"), EventType.event,
      reason: "EventType translation should be case-insensitive");
    expect(EventType.fromString("Announcements"), EventType.announcement,
      reason: "Plural forms of strings should still be valid");
  });

  test('EventTypes should be filterable via EventTypeFilters', () {
    final correctPairs = <EventType, EventTypeFilter>{
      EventType.event: EventTypeFilter.events,
      EventType.announcement: EventTypeFilter.announcements,
      EventType.meeting: EventTypeFilter.meetings,
    };

    for (EventType et in EventType.values) {
      final correctFilter = correctPairs[et];

      for (EventTypeFilter etf in EventTypeFilter.values) {
        bool expectedResult = false;

        if (etf == EventTypeFilter.all || etf == correctFilter) {
          expectedResult = true;
        }

        expect(et.matchesFilter(etf), expectedResult,
          reason: "Each EventType should match its corresponding filter and "
                  "the All filter and no others.");
      }
    }
  });
}
