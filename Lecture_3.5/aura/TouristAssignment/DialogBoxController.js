({
    handleConfirmDialogYes : function(component, event, helper) {
        let eventButtonYes = component.getEvent("eventButtonYes");
        eventButtonYes.fire();
    },
    
    handleConfirmDialogNo : function(component, event, helper) {
        let eventButtonNo = component.getEvent("eventButtonNo");
        eventButtonNo.fire();
    },
})