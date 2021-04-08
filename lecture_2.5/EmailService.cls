public class EmailService {
    
    public static void sendEmailMessage(Map<Tourists__c, Integer> touristMap) {
        List<String> emails = new List<String>(TouristManager.getMetaEmails());
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject(Constants.MAIL_SUBJECT);
        email.setToAddresses(emails);
        email.plainTextBody = ' ';
        
        for (Tourists__c tourist : touristMap.keySet()) {
            email.plainTextBody += ' Tourist ' + tourist.Name + ' had  ' + touristMap.get(tourist) + ' remote flights. ';
        }
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});       
    }
}