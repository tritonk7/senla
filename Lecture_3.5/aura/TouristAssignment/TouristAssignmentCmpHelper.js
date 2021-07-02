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
        let selectedTrip = component.get("v.tripData")[index];
        component.set("v.selectedTrip", selectedTrip);
        component.set("v.tripId", selectedTrip.Id);
        component.set("v.tripName", selectedTrip.Name);
        component.set("v.minimumAge", selectedTrip.Mininmum_Age__c);
        component.set("v.spacePoint", selectedTrip.Departure_Space_Point__r.City__c);
        component.set("v.seats", selectedTrip.Seats__c);
    },  
    
    handleCreateFlight : function(component, event) {
        let id = component.get("v.touristId");
        let tripId = component.get("v.tripId");
        let action = component.get("c.createFlight");
        action.setParams({
            tripId: tripId,
            touristId: id
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
        component.set("v.isDisableButton", true);
        let touristAge = component.get("v.touristAge");
        let tripAge = component.get("v.minimumAge");
        let city = component.get("v.spacePoint");
        if (touristAge >= tripAge && component.get("v.freeSeats") > 0) {
            component.set("v.isDisableButton", false);
        } else {
            component.set("v.isDisableButton", true);
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
            component.set("v.isDisableButton", true);
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
                component.set("v.tripData", records);
            }
        });
        $A.enqueueAction(action);
    },
    
        fetchTourist : function(component) {
        let action = component.get("c.fetchTourist");
        let id = component.get("v.touristId");
        action.setParams({
            touristsId : id
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                component.set("v.touristAge", records[0].Tourist_Age__c);
            }
        });
        $A.enqueueAction(action);
    }
})