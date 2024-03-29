({    
    fetchFlights : function(component) {
        let action = component.get("c.fetchFlights");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                if (records.length > 0) {
                    component.set("v.flightData", records);
                } else {
                    component.set("v.flightData", []);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchWeather : function(component) {
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
        let selectedItem = event.currentTarget;
        let index = selectedItem.dataset.record;
        let selectedTrip = component.get("v.data")[index];
        component.set('v.tripId',selectedTrip.Id);
        component.set('v.startDate',selectedTrip.Start_Data__c);
        component.set('v.endDate',selectedTrip.End_Date__c);
        component.set('v.tripName',selectedTrip.Name);
        component.set('v.minimumAge',selectedTrip.Mininmum_Age__c);
        component.set('v.spacePoint',selectedTrip.Departure_Space_Point__r.City__c);
        component.set('v.seats',selectedTrip.Seats__c);
    },  
    
    handleCreateFlight : function(component, event) {
        let touristId = component.get("v.touristId");
        let tripId = component.get("v.tripId");
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
    },
    
    validationTrip : function(component) {
        let tripId = component.get("v.tripId");
        let tripsId =  [];
        let flights = component.get("v.flightData");
        
        for (let i = 0; i < flights.length; i++) {
            if (tripId == flights[i].Trip__c) {
                tripsId.push(flights[i].Trip__c); 
            }
        }
        component.set("v.freeSeats", component.get("v.seats") - tripsId.length);
        let weather = component.get("v.weather");
        let city = component.get("v.spacePoint")
        
        for (let i = 0; i < weather.length; i++) {
            if (city == weather[i].Space_Point__r.City__c) {
                component.set("v.temperature", weather[i].Average_Temperature__c);
            }
        }
    },
    
    validationSubmit : function(component) {
        component.set("v.isVisibleButton", false);
        let touristAge = component.get("v.touristAge");
        let tripAge = component.get("v.minimumAge");
        let city = component.get("v.spacePoint");
        if (touristAge >= tripAge && component.get("v.freeSeats") > 0) {
            component.set("v.isVisibleButton", true);
        } else {
            component.set("v.isVisibleButton", false);
        }
        if (typeof(city) != "UNDEFINED") {
            component.set("v.isVisibleMap", true);
            component.set("v.mapMarkers", [
                {
                    location: {
                        City: city
                    },
                }
            ]);
            component.set("v.zoomLevel", 10);
        }
    },
    
    fetchTrips : function(component) {
        let action = component.get("c.fetchTrips");
        let id = component.get("v.touristId");
        if (typeof(id) === "UNDEFINED") {
            component.set("v.isVisibleButton", false);
            component.set("v.isVisible", false);
            component.set("v.isVisibleMap", false);
        } else {
            component.set("v.isVisible", true);
        }
        action.setParams({
            touristsId : id
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                component.set("v.data", records);
            }
        });
        $A.enqueueAction(action);
    }
})