({
    fetchTourists : function(component, event) {
        var action = component.get("c.fetchTourist");
        action.setParams({
            tripId: component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                records.forEach(function(record){
                    record.linkName = '/'+ record.Id;
                });
                component.set("v.data", records);
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchFlights : function(component, event) {
        var records = component.get("v.selectedTourists");
        var ids = new Array();
        
        for ( var i = 0; i < records.length; i++ ) {
            ids.push(records[i].Id);
        } 
        var action = component.get("c.saveFlight");
        action.setParams({tripId: component.get("v.recordId"),
                          touristIds: ids
                         });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var name = response.getReturnValue();
            }
        });
        $A.enqueueAction(action);
    }  
})