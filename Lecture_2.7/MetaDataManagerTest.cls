@isTest
public class MetaDataManagerTest {
    
    @isTest
    public static void testGetMetaEmails() {
        Set<String> emails = MetaDataManager.getMetaEmails();
        System.assertEquals(1, emails.size());
    }
}