({
    selectRecord : function(component, event, helper){      
        let getSelectRecord = component.get("v.oRecord");
        let compEvent = component.getEvent("oSelectedRecordEvent");
        compEvent.setParams({"recordByEvent" : getSelectRecord });  
        compEvent.fire();
    },
})