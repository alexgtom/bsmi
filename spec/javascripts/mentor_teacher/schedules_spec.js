

describe("updateEventInForm", function() {
    
    beforeEach(function() {
        loadFixtures('mentor_teacher/schedule_form.html');
        $form = $("#schedule_form");
        calEvent = {start: new Date("10:30 AM 01/03/2000"),
                    end: new Date("11:30 AM 01/03/2000"),
                    title: "My class",
                    id: 3
                   };
        inputId = "eventInput" + calEvent.id;
    });
    
    describe("if the event exists", function() {
        beforeEach(function() {

            $eventInput = $('<input/>', 
                            {'id':inputId,
                             'value': "foo"
                            }
                           );
            $eventInput.insertBefore($form.find('input[type="submit"]'));
        });

        it("should update the event's value", function() {
            updateEventInForm(calEvent);            
            expect($("#" + inputId).val()).toBe(JSON.stringify(calEvent));
        });
    });

    describe("if the event doesn't exist", function() {                   
        it("should add a field for the event", function() {
            updateEventInForm(calEvent);
            expect($("#" + inputId)).toExist();
        });
        
    });

});

