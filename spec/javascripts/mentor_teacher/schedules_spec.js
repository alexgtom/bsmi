

describe("updateEventInForm", function() {
    
    beforeEach(function() {
        loadFixtures('mentor_teacher/schedule_form.html');
        $form = $("#schedule_form");
        calEvent = {start: new Date("10:30 AM 01/03/2000"),
                    end: new Date("11:30 AM 01/03/2000"),
                    title: "My class",
                    id: 3
                   };
    });
    
    describe("if the event exists", function() {
        beforeEach(function() {
            // $eventInput.insertBefore($form.find('input[type="submit"]'));
        });

        it("should update the event's value", function() {
            
        });
    });

    describe("if the event doesn't exist", function() {           
        
        it("should add a field for the event", function() {
//            updateE
        });
        
    });

});

