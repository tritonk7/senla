({
    fetchTourists : function(component, event) {
        var action = component.get("c.fetchTourist");
       
        action.setParams({
            tripId: component.get("v.recordId")
        });
       
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var responseValue = response.getReturnValue();
            }
            
             component.set("v.data", responseValue);
        });
        
        $A.enqueueAction(action);
    },
    
    fetchFlights : function(component, event) {
       
        var records = component.get("v.selectedTourists");
        var ids = new Array();
        
        for ( var i = 0; i < records.length; i++ ) {
            alert(records[i].Id);
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
                    alert('Flights did created');
                }
            });
            
            $A.enqueueAction(action);
        
    }
  
})