({ 
    fetchTourists : function(component, event) {       
        let action = component.get("c.fetchTourists");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                records.forEach(function(record) {
                    record.linkName = '/' + record.Id;
                });
                component.set("v.touristData", records);
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchTrip : function(component, event) {
        let action = component.get("c.fetchTrip");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                records.forEach(function(record) {
                    record.linkName = '/' + record.Id;
                });
                component.set("v.data", records);
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchFlights : function(component, event) {
        let action = component.get("c.fetchFlights");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                if (records.length > 0) {
                    component.set("v.flightData", records);
                } else {
                    component.set("v.flightData",[]);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchWeather : function(component, event) {
        let action = component.get("c.fetchWeather");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                if (records.length > 0) {
                    component.set("v.weather", records);
                } 
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchTripSelectedRows : function (component, event) {
        let selectedRows = event.getParam("selectedRows"); 
        component.set('v.tripId',selectedRows[0].Id);
        component.set('v.setStartDate',selectedRows[0].Start_Data__c);
        component.set('v.tripName',selectedRows[0].Name);
        component.set('v.minimumAge',selectedRows[0].Mininmum_Age__c);
        component.set('v.setEndDate',selectedRows[0].End_Date__c);
        component.set('v.setSpacePoint',selectedRows[0].Departure_Space_Point__r.City__c);
        component.set('v.setSeats',selectedRows[0].Seats__c);
    },
    
    handleCreateFlight : function(component, event) {
        let touristId =component.get("v.touristId");
        let tripId =component.get("v.tripId");
        let action = component.get("c.createFlight");
        action.setParams({
            tripId: tripId,
            touristId: touristId
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message: $A.get("$Label.c.Added_Tourists"),
                    duration:' 4000',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);
    }
})