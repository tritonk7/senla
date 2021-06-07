({
    fetchTourists : function(component, event) {
        var action = component.get("c.fetchTourist");
        action.setParams({
            tripId : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var records = response.getReturnValue();
                records.forEach(function(record) {
                    record.linkName = '/' + record.Id;
                });
                component.set("v.data", records);
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchFlights : function(component, event) {
        var records = component.get("v.selectedTourists");
        var ids = [];
        
        for (var i = 0; i < records.length; i++) {
            ids.push(records[i].Id);
        } 
        var action = component.get("c.saveFlight");
        action.setParams({tripId : component.get("v.recordId"),
                          touristIds : ids
                         });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                if (result.length > 0) {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        message: $A.get("$Label.c.Added_Tourists"),
                        duration:' 4000',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                } else {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        message: $A.get("$Label.c.Error_Trip"),
                        duration:' 4000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchSeats : function(component, event) {
        var freeSeats = component.get("c.getSeats");
        freeSeats.setParams({
            tripId : component.get("v.recordId")
        });
        freeSeats.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.setSeats", result);
            }
        });
        $A.enqueueAction(freeSeats); 
    },
    
    fetchStartDate : function(component, event) {
        var freeSeats = component.get("c.getStartDate");
        freeSeats.setParams({
            tripId : component.get("v.recordId")
        });
        freeSeats.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.setStartDate", result);
            }
        });
        $A.enqueueAction(freeSeats); 
    }
})