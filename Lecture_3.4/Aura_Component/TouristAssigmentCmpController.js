{
    doInit : function(component, event, helper) {
        component.set("v.columns", [
            {label: "Trip Name", fieldName: "linkName", type: "url", 
             typeAttributes: { label: { fieldName: 'Name' }, target: "_self", tooltip: {fieldName: "Name" }}},
            {label: 'Start Date', fieldName: 'Start_Data__c', type: 'Date'}
        ]);
        helper.fetchFlights(component, event);
        helper.fetchWeather(component, event);
        let today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.setToday", today);
    },
    
    handleSelectTourist: function (component, event) {
        let ids = component.get("v.selectedLookUpRecord");
        let touristId = component.set("v.touristId", ids.Id);
        let touristAge = component.set("v.touristAge", ids.Tourist_Age__c);
    },
    
    selectedTrip: function (component, event) {
        let action = component.get("c.fetchTrip");
        let id = component.get("v.touristId");
        if (typeof(id) == "undefined") {
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
                records.forEach(function(record) {
                    record.linkName = '/' + record.Id;
                });
                component.set("v.data", records);
            }
        });
        $A.enqueueAction(action); 
    },
    
    handleSelect : function(component, event, helper) {
        helper.fetchTripSelectedRows(component, event);
        let tripId = component.get("v.tripId");
        let tripsId =  [];
        let flights = component.get("v.flightData");
        for (let i = 0; i < flights.length; i++) {
            if (tripId == flights[i].Trip__c) {
                tripsId.push(flights[i].Trip__c); 
            }
        }
        component.set("v.freeSeats", component.get("v.setSeats") - tripsId.length);
        let weather = component.get("v.weather");
        let city = component.get("v.setSpacePoint")
        
        for (let i = 0; i < weather.length; i++) {
            if (city == weather[i].Space_Point__r.City__c) {
                component.set("v.setTemperature", weather[i].Average_Temperature__c);
            }
        } 
    },
    
    onChange : function(component, event, helper) {
        component.set("v.isVisibleButton", false);
        let touristAge = component.get("v.touristAge");
        let tripAge = component.get("v.minimumAge");
        let city = component.get("v.setSpacePoint");
        if (touristAge >= tripAge && component.get("v.freeSeats") > 0) {
            component.set("v.isVisibleButton", true);
        } else {
            component.set("v.isVisibleButton", false);
        }
        if (typeof(city) != "undefined") {
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
    
    handleConfirmDialog : function(component, event, helper) {
        component.set("v.showConfirmDialog", true);
    },
    
    handleConfirmDialogYes : function(component, event, helper) {
        helper.handleCreateFlight(component, event);
        component.set("v.showConfirmDialog", false);
    },
    
    handleConfirmDialogNo : function(component, event, helper) {
        component.set("v.showConfirmDialog", false);
    },
    
    handleClean : function(component, event, helper) {
        $A.get("e.force:refreshView").fire();
        component.set("v.isVisibleMap", false);
        component.set("v.isVisible", false);
    }
})