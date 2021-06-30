({
    doInit : function(component, event, helper) {
        helper.fetchTourists(component);
        helper.fetchSeats(component);
        helper.fetchStartDate(component);
        
        let today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.today", today);
    },
    
    dataTableUpdate : function(component, event, helper) {
        helper.fetchTourists(component);
        helper.fetchSeats(component); 
        component.set("v.isRefreshTable", false);
    },
    
    onChange : function(component, event, helper) {
        helper.fetchVisibleButton(component);
    },
    
    handleSelect : function(component, event, helper) {
        helper.fetchSelectedRows(component, event);
    },
    
    handleConfirmDialog : function(component, event, helper) {
        helper.fetchValidation(component);
    },
    
    handleConfirmDialogYes : function(component, event, helper) {
        component.set("v.isShowConfirmDialog", false);
        helper.fetchFlights(component);
    },
    
    handleConfirmDialogNo : function(component, event, helper) {
        component.set("v.isShowConfirmDialog", false);
    },
    
    handleShowSpinner: function(component, event, helper) {
        component.set("v.isShowSpinner", true);
    },
    
    handleHideSpinner : function(component, event, helper){
        component.set("v.isShowSpinner", false);
    }
})