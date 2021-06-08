({
    fetchTourists : function(component, event) {
        let action = component.get("c.fetchTourist");
        action.setParams({
            tripId : component.get("v.recordId")
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
    
    fetchFlights : function(component, event) {
        let records = component.get("v.selectedTourists");
        let ids = [];
        
        for (let i = 0; i < records.length; i++) {
            ids.push(records[i].Id);
        } 
        let action = component.get("c.saveFlight");
        action.setParams({tripId : component.get("v.recordId"),
                          touristIds : ids
                         });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let result = response.getReturnValue();
                if (result.length > 0) {
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        message: $A.get("$Label.c.Added_Tourists"),
                        duration:' 4000',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                } else {
                    let toastEvent = $A.get("e.force:showToast");
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
    
    fetchValidation : function(component, event) {
        let selectedRows = component.get("v.selectedTourists");
        let seats = component.get("v.setSeats");
        let setRow = [];
        let startDate = component.get("v.setStartDate");
        let today = component.get("v.setToday");
        
        for (let i = 0; i < selectedRows.length; i++) {
            setRow.push(selectedRows[i]);
        } 
        
        if (setRow.length > seats || setRow.length == 0) {
            if (setRow.length > seats) {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message: $A.get("$Label.c.NotEnoughtlSeats"),
                    duration:' 4000',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire(); 
            }
            if (setRow.length == 0) {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message:  $A.get("$Label.c.TouristsIsNotSelected"),
                    duration:' 4000',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire(); 
            } 
        } else {
            component.set("v.showConfirmDialog", true);  
        } 
    },
    
    fetchSeats : function(component, event) {
        let freeSeats = component.get("c.getSeats");
        freeSeats.setParams({
            tripId : component.get("v.recordId")
        });
        freeSeats.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let result = response.getReturnValue();
                component.set("v.setSeats", result);
            }
        });
        $A.enqueueAction(freeSeats);
    },
    
    fetchStartDate : function(component, event) {
        let freeSeats = component.get("c.getStartDate");
        freeSeats.setParams({
            tripId : component.get("v.recordId")
        });
        freeSeats.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let result = response.getReturnValue();
                component.set("v.setStartDate", result);
            }
        });
        $A.enqueueAction(freeSeats); 
    },
    
    fetchSelectedRows : function (component, event) {
        let selectedRows = event.getParam("selectedRows"); 
        let setRows = [];
        
        for (let i = 0; i < selectedRows.length; i++) {
            setRows.push(selectedRows[i]);
        }
        component.set("v.selectedTourists", setRows);
    },
    
    fetchVisibleButton : function (component, event) {
        let seats = component.get("v.setSeats");
        let today = component.get("v.setToday");
        let startDate = component.get("v.setStartDate");
        if (seats <= 0 || startDate < today) {
            component.set("v.isVisibleButton",false);
        } else {
            component.set("v.isVisibleButton",true);
        }
    }
})