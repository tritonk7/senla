({
    doInit: function (component, event, helper) {
        component.set('v.columns', [
            {label: 'Tourist Name', fieldName: 'Name', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, target: '_parent'}},
            {label: 'Email', fieldName: 'Tourist_Email__c', type: 'email'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'picklist'}
        ]);
        helper.fetchTourists(component, event);
    },
    
    createFlight: function(component, event, helper) {
        helper.fetchFlights(component, event);
    },
    
    handleSelect : function(component, event, helper) {
        var selectedRows = event.getParam('selectedRows'); 
        var setRows = [];
        for ( var i = 0; i < selectedRows.length; i++ ) {
            setRows.push(selectedRows[i]);
        }
        component.set("v.selectedAccts", setRows);
        
    },
    
    handleShowSpinner: function(component, event, helper) {
        component.set("v.showSpinner", true); 
    },
    
    handleHideSpinner : function(component,event,helper){
        component.set("v.showSpinner", false);
    }
})