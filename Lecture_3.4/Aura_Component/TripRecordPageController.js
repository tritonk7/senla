({
    doInit : function (component, event, helper) {
        component.set("v.columns", [
            {label: 'Tourist Name', fieldName: 'linkName', type: 'url', 
             typeAttributes: { label: { fieldName: 'Name' }, target: '_self', tooltip: {fieldName: 'Name' }}},
            {label: 'Email', fieldName: 'Tourist_Email__c', type: 'email'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'picklist'}
        ]);
        helper.fetchTourists(component, event);
        helper.fetchSeats(component, event);
        helper.fetchStartDate(component, event);
        
        let today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.setToday", today);
    },
    
    onChange : function(component, event, helper) {
        helper.fetchVisibleButton(component, event);
    },
    
    handleSelect : function(component, event, helper) {
        helper.fetchSelectedRows(component, event);
    },
    
    handleConfirmDialog : function(component, event, helper) {
        helper.fetchValidation(component, event);
    },
    
    handleConfirmDialogYes : function(component, event, helper) {
        helper.fetchFlights(component, event);
        component.set("v.showConfirmDialog", false);
    },
    
    handleConfirmDialogNo : function(component, event, helper) {
        component.set("v.showConfirmDialog", false);
    },
    
    handleShowSpinner: function(component, event, helper) {
        component.set("v.showSpinner", true); 
    },
    
    handleHideSpinner : function(component, event, helper){
        component.set("v.showSpinner", false);
    }
})