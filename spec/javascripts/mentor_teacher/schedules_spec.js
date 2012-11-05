

describe("selectOptionWithValue", function () {
    beforeEach(function () {
        loadFixtures("mentor_teacher/select.html")
        toSelect = "2";
        makeCall = function () {
            $field = $("select")
            selectOptionWithValue($field, toSelect);
        }
    });
    it("should select the appropriate value", function () {
        makeCall();
        expect($('option[value="2"]')).toBeSelected();
    });

    it ("should unselect the previously selected value", function() {
        makeCall();
        expect($('option[value="1"]')).not.toBeSelected();
    });

});

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
            var fakeCalEvent = {id : 3, start : "start", end : "end"};
            spyOn(window, 'asUTC');
            spyOn(JSON, 'stringify').andReturn("event");
            updateEventInForm(fakeCalEvent);            
            expect($("#" + inputId).val()).toBe("event");
        });

        it("should convert the start date to UTC", function() {
            var fakeCalEvent = {id : 3, start : "start"};
            spyOn(window, 'asUTC');
            updateEventInForm(fakeCalEvent);            
            expect(window.asUTC).toHaveBeenCalledWith("start");
        });
        it("should convert the end date to UTC", function() {
            var fakeCalEvent = {id : 3, end : "end"};
            spyOn(window, 'asUTC');
            updateEventInForm(fakeCalEvent);            
            expect(window.asUTC).toHaveBeenCalledWith("end");
        });

    });

    describe("if the event doesn't exist", function() {                   
        it("should add a field for the event", function() {
            updateEventInForm(calEvent);
            expect($("#" + inputId)).toExist();
        });
        
    });

});

