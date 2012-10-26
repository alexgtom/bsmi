
/* 
 * Callbacks for the mentor teacher schedule calendar
 * 
 * Large chunks of this code are taken from https://github.com/themouette/jquery-week-calendar/blob/master/full_demo/demo.js 
 */


/* Global event id */
timeslotID = 0;

function nextEventID() {
    timeslotID++;
    return timeslotID;
}


function setTimeFields($timeFields, time) {
    var hoursStr = time.hours < 10 ? "0" + time.hours : time.hours.toString();
    $timeFields.val([zeroify(time.getHours()), zeroify(time.getMinutes())])
}

function extractTime($timeFields) {
    var rtn = new Date
    rtn.setHours($timeFields[0].value);
    rtn.setMinutes($timeFields[1].value);
    return rtn;
}

function zeroify(num) {
    return num < 10 ? "0" + num : num + "";
}

function eventNewCallback (calEvent, $event) {
    var $calendar = $('#calendar');


    var $dialogContent = $("#event_edit_container");
    resetForm($dialogContent);

    var $startFields = $dialogContent.find("select.start_time");
    var $endFields = $dialogContent.find("select.end_time");
    setTimeFields($startFields, calEvent.start);
    setTimeFields($endFields, calEvent.end);

    // var titleField = $dialogContent.find("input[name='title']");
    // var bodyField = $dialogContent.find("textarea[name='body']");


    $dialogContent.dialog({
        modal: true,
        title: "New Calendar Event",
        close: function() {
            $dialogContent.dialog("destroy");
            $dialogContent.hide();
            $('#calendar').weekCalendar("removeUnsavedEvents");
        },
        buttons: {
            save : function() {
                calEvent.id = nextEventID();
                calEvent.start = extractTime($startFields);
                calEvent.end = extractTime($endFields);
                debugger;
                // calEvent.title = titleField.val();
                // calEvent.body = bodyField.val();

                $calendar.weekCalendar("updateEvent", calEvent);
                $calendar.weekCalendar("removeUnsavedEvents");

                $dialogContent.dialog("close");
            },
            cancel : function() {
                $dialogContent.dialog("close");
            }
        }
    }).show();

    $dialogContent.find(".date_holder").text($calendar.weekCalendar("formatDate", calEvent.start));
    setupStartAndEndTimeFields(startField, endField, calEvent, $calendar.weekCalendar("getTimeslotTimes", calEvent.start));

}

function resetForm($dialogContent) {
    $dialogContent.find("input").val("");
    $dialogContent.find("textarea").val("");
}



/*
 * Sets up the start and end time fields in the calendar event
 * form for editing based on the calendar event being edited
 */
function setupStartAndEndTimeFields($startTimeField, $endTimeField, calEvent, timeslotTimes) {
    
    $startTimeField.empty();
    $endTimeField.empty();

    for (var i = 0; i < timeslotTimes.length; i++) {
        var startTime = timeslotTimes[i].start;
       var endTime = timeslotTimes[i].end;
        var startSelected = "";
        if (startTime.getTime() === calEvent.start.getTime()) {
            startSelected = "selected=\"selected\"";
        }
        var endSelected = "";
        if (endTime.getTime() === calEvent.end.getTime()) {
            endSelected = "selected=\"selected\"";
        }
        $startTimeField.append("<option value=\"" + startTime + "\" " + startSelected + ">" + timeslotTimes[i].startFormatted + "</option>");
        $endTimeField.append("<option value=\"" + endTime + "\" " + endSelected + ">" + timeslotTimes[i].endFormatted + "</option>");

        $timestampsOfOptions.start[timeslotTimes[i].startFormatted] = startTime.getTime();
        $timestampsOfOptions.end[timeslotTimes[i].endFormatted] = endTime.getTime();

    }
    $endTimeOptions = $endTimeField.find("option");
    $startTimeField.trigger("change");
}

var $endTimeField = $("select[name='end']");
var $endTimeOptions = $endTimeField.find("option");
var $timestampsOfOptions = {start:[],end:[]};

//reduces the end time options to be only after the start time options.
$("select[name='start']").change(function() {
    var startTime = $timestampsOfOptions.start[$(this).find(":selected").text()];
    var currentEndTime = $endTimeField.find("option:selected").val();
    $endTimeField.html(
        $endTimeOptions.filter(function() {
            return startTime < $timestampsOfOptions.end[$(this).text()];
        })
    );

    var endTimeSelected = false;
    $endTimeField.find("option").each(function() {
        if ($(this).val() === currentEndTime) {
            $(this).attr("selected", "selected");
            endTimeSelected = true;
            return false;
        }
    });

    if (!endTimeSelected) {
        //automatically select an end date 2 slots away.
        $endTimeField.find("option:eq(1)").attr("selected", "selected");
    }

});









// /* Callback for creation of an event in the calendar 
//  * 
//  */
// function eventNewCallback (calEvent, $event) {

//     popupTimeslotDialog(calEvent);




// }


// function popupTimeslotDialog(calEvent)  {
//     var $calendar = $('#calendar')
//     var $dialogContent = $("#event_edit_container");
//     resetForm($dialogContent);
//     var startField = $dialogContent.find("select[name='start_time']").val(calEvent.start); 
//     var endField = $dialogContent.find("select[name='end_time']").val(calEvent.start); 
//    $dialogContent.dialog({
//         modal: true,
//         title: "New class", 
//         close: function() {
//             $dialogContent.dialog("destroy");
//             $dialogContent.hide();
//             $('#calendar').weekCalendar("removeUnsavedEvents");
//         },
//         buttons: {
//             save : function() {
//                 calEvent.id = nextEventID();

//                 calEvent.start = new Date(startField.val());
//                 calEvent.end = new Date(endField.val());
//                 // calEvent.title = titleField.val();
//                 // calEvent.body = bodyField.val();

//                 $calendar.weekCalendar("updateEvent", calEvent);
//                 $calendar.weekCalendar("removeUnsavedEvents");
//                 $dialogContent.dialog("close");
//             },
//             cancel : function() {
//                 $dialogContent.dialog("close");
//             }
//         }
//     }).show();

//     $dialogContent.find(".date_holder").text($calendar.weekCalendar("formatDate", calEvent.start));
//     setupStartAndEndTimeFields(startField, endField, calEvent, $calendar.weekCalendar("getTimeslotTimes", calEvent.start));

// }

// function resetForm($dialogContent) {
//     $dialogContent.find("input").val("");
//     $dialogContent.find("textarea").val("");
// }


//    /*
//     * Sets up the start and end time fields in the calendar event
//     * form for editing based on the calendar event being edited
//     */
// function setupStartAndEndTimeFields($startTimeField, $endTimeField, calEvent, timeslotTimes) {

//     $startTimeField.empty();
//     $endTimeField.empty();

//     for (var i = 0; i < timeslotTimes.length; i++) {
//         var startTime = timeslotTimes[i].start;
//         var endTime = timeslotTimes[i].end;
//         var startSelected = "";
//         if (startTime.getTime() === calEvent.start.getTime()) {
//             startSelected = "selected=\"selected\"";
//         }
//         var endSelected = "";
//         if (endTime.getTime() === calEvent.end.getTime()) {
//             endSelected = "selected=\"selected\"";
//         }
//         $startTimeField.append("<option value=\"" + startTime + "\" " + startSelected + ">" + timeslotTimes[i].startFormatted + "</option>");
//         $endTimeField.append("<option value=\"" + endTime + "\" " + endSelected + ">" + timeslotTimes[i].endFormatted + "</option>");

//         $timestampsOfOptions.start[timeslotTimes[i].startFormatted] = startTime.getTime();
//         $timestampsOfOptions.end[timeslotTimes[i].endFormatted] = endTime.getTime();

//     }
//     $endTimeOptions = $endTimeField.find("option");
//     $startTimeField.trigger("change");
// }

// var $endTimeField = $("select[name='end']");
// var $endTimeOptions = $endTimeField.find("option");
// var $timestampsOfOptions = {start:[],end:[]};

//    //reduces the end time options to be only after the start time options.
// $("select[name='start']").change(function() {
//     var startTime = $timestampsOfOptions.start[$(this).find(":selected").text()];
//     var currentEndTime = $endTimeField.find("option:selected").val();
//     $endTimeField.html(
//         $endTimeOptions.filter(function() {
//             return startTime < $timestampsOfOptions.end[$(this).text()];
//         })
//     );

//     var endTimeSelected = false;
//     $endTimeField.find("option").each(function() {
//         if ($(this).val() === currentEndTime) {
//             $(this).attr("selected", "selected");
//             endTimeSelected = true;
//             return false;
//         }
//     });

//     if (!endTimeSelected) {
//          //automatically select an end date 2 slots away.
//         $endTimeField.find("option:eq(1)").attr("selected", "selected");
//     }

// });
