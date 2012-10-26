
/* 
 * Callbacks for the mentor teacher schedule calendar
 */


/* Global event id */
timeslotID = 0;

function nextEventID() {
    return timeslotID++;
}

/* Callback for creation of an event in the calendar 
 * 
 */
function eventNewCallback (calEvent, $event) {
    calEvent["domID"] = nextEventID();
    $("<input/>").attr({"type": "hidden",
                        "id" : calEvent["domID"],
                        "value": JSON.stringify(calEvent),
                        "name": "timeslots[]"
                       }).appendTo('#schedule_form');                        
}
