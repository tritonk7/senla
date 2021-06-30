({
    fetchTourists : function(component) {
        component.set("v.columns", 
                      [             
                          {
                              label: 'Tourist Name', 
                              fieldName: 'linkName',
                              type: 'url', 
                              typeAttributes: { 
                                  label: { 
                                      fieldName: 'Name' 
                                  },
                                  target: '_self',
                                  tooltip: {
                                      fieldName: 'Name' 
                                  }
                              }
                          },
                          {
                              label: 'Email',
                              fieldName: 'Tourist_Email__c',
                              type: 'email'
                          },
                          {
                              label: 'Gender',
                              fieldName: 'Gender__c',
                              type: 'picklist'
                          }
                      ]
                     );
        
        let action = component.get("c.fetchTourists");
        action.setParam({
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
    
    fetchFlights : function(component) {
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
                    component.set("v.isRefreshTable", true);
                } else {
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        message: $A.get("$Label.c.Error_Trip"),
                        duration:' 4000',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchValidation : function(component) {
        let selectedRows = component.get("v.selectedTourists");
        let seats = component.get("v.seats");
        let setRow = [];
        let startDate = component.get("v.startDate");
        let today = component.get("v.today");
        
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
            component.set("v.isShowConfirmDialog", true);  
        } 
    },
    
    fetchSeats : function(component) {
        let freeSeats = component.get("c.getSeats");
        freeSeats.setParams({
            tripId : component.get("v.recordId")
        });
        freeSeats.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let result = response.getReturnValue();
                component.set("v.seats", result);
            }
        });
        $A.enqueueAction(freeSeats);
    },
    
    fetchStartDate : function(component) {
        let freeSeats = component.get("c.getStartDate");
        freeSeats.setParams({
            tripId : component.get("v.recordId")
        });
        freeSeats.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let result = response.getReturnValue();
                component.set("v.startDate", result);
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
    
    fetchVisibleButton : function (component) {
        let seats = component.get("v.seats");
        let today = component.get("v.today");
        let startDate = component.get("v.startDate");
        if (seats <= 0 || startDate <= today) {
            component.set("v.isVisibleButton",false);
        } else {
            component.set("v.isVisibleButton",true);
        }
    }
})