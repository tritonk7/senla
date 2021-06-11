({
    doInit : function(component, event, helper) {
        component.set("v.tourist", [
            {label: "Tourist Name", fieldName: "linkName", type: "url", 
             typeAttributes: { label: { fieldName: "Name" }, target: "_self", tooltip: {fieldName: "Name" }}},
            {label: 'Age', fieldName: 'Tourist_Age__c', type: 'Integer'} 
        ]);
        component.set("v.columns", [
            {label: "Trip Name", fieldName: "linkName", type: "url", 
             typeAttributes: { label: { fieldName: 'Name' }, target: "_self", tooltip: {fieldName: "Name" }}},
            {label: 'Start Date', fieldName: 'Start_Data__c', type: 'Date'}
        ]);
        helper.fetchTourists(component, event);
        helper.fetchTrip(component, event);
        helper.fetchFlights(component, event);
        helper.fetchWeather(component, event);
        let today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.setToday", today);
    },
    
    handleSelectTourist: function (component, event) {
        let selectedRows = event.getParam("selectedRows");
        component.set("v.touristAge", selectedRows[0].Tourist_Age__c);
        component.set("v.touristId", selectedRows[0].Id);
        if (selectedRows.length > 0) {
            component.set("v.isVisible", true);
        }else {
            component.set("v.isVisible", false);
        } 
    },
    
    handleSelect : function(component, event, helper) {
        helper.fetchTripSelectedRows(component, event);
        let flight  = component.get("v.flightData");
        let tripId = component.get("v.tripId");
        let busySeats = [];
        let weather = component.get("v.weather");
        let city = component.get("v.setSpacePoint")
        
        for (let i = 0; i < weather.length; i++) {
            if (city == weather[i].Space_Point__r.City__c) {
                component.set("v.setTemperature", weather[i].Average_Temperature__c);
            }
        }
        
        for (let i = 0; i < flight.length; i++) {
            if(tripId == flight[i]) {
                busySeats.push(flight[i]);
                component.set("v.busySeats",busySeats.length);
            }  
        }
        let freeSeats  = component.get("v.setSeats") - component.get("v.busySeats");
        component.set("v.setFreeSeats",freeSeats);
        
    },
    
    onChangeTourist : function(component, event, helper) {
        let touristAge = component.get("v.touristAge");
        let tripAge = component.get('v.minimumAge');
        let city = component.get("v.setSpacePoint");
        let check = typeof city;
        let freeSeats = component.get("v.setFreeSeats");
        if (touristAge >= tripAge && freeSeats > 0) {
            component.set("v.isVisibleButton", true);
        } else {
            component.set("v.isVisibleButton", false);
        }
        if (check != "undefined" ) {
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