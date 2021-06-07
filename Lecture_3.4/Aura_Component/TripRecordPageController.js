({
    doInit : function (component, event, helper) {
        component.set("v.columns", [
            {label: 'Tourist Name', fieldName: 'linkName', type: 'url', 
             typeAttributes: { label: { fieldName: 'Name' }, target: '_self', tooltip: {fieldName: 'Name' }}},
            {label: 'Email', fieldName: 'Tourist_Email__c', type: 'email'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'picklist'}
        ]);
        helper.fetchTourists (component, event);
        helper.fetchSeats (component, event);
        helper.fetchStartDate (component, event);
        
        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.setToday", today);
    },
    
    handleSelect : function(component, event, helper) {
        var selectedRows = event.getParam("selectedRows"); 
        var setRows = [];
        
        for (var i = 0; i < selectedRows.length; i++) {
            setRows.push(selectedRows[i]);
        }
        component.set("v.selectedTourists", setRows);
    },
    
    handleShowSpinner: function(component, event, helper) {
        component.set("v.showSpinner", true); 
    },
    
    handleHideSpinner : function(component, event, helper){
        component.set("v.showSpinner", false);
    },
    
    handleConfirmDialog : function(component, event, helper) {
        var selectedRows = component.get("v.selectedTourists");
        var seats = component.get("v.setSeats");
        var setRow = [];
        var startDate = component.get("v.setStartDate");
        var today = component.get("v.setToday");
        
        for (var i = 0; i < selectedRows.length; i++) {
            setRow.push(selectedRows[i]);
        } 
        
        if (setRow.length > seats || startDate <= today) {
            if (setRow.length > seats) {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message: $A.get("$Label.c.NotEnoughtlSeats"),
                    duration:' 4000',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire(); 
            }
            if (startDate <= today) {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message:  $A.get("$Label.c.TripAlreadyBegun"),
                    duration:' 4000',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire(); 
            } 
        } else 
            if (seats >= setRow.length && startDate >= today && seats > 0) {
                component.set("v.showConfirmDialog", true);  
            }  
    },
    
    handleConfirmDialogYes : function(component, event, helper) {
        helper.fetchFlights(component, event);
        component.set("v.showConfirmDialog", false);
    },
    
    handleConfirmDialogNo : function(component, event, helper) {
        component.set("v.showConfirmDialog", false);
    }
})