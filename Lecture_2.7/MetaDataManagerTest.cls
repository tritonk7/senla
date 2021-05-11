@IsTest
private class MetaDataManagerTest {
    
    @IsTest
    private static void testGetMetaEmails() {
        Set<String> emails = MetaDataManager.getMetaEmails();
        
        System.assertNotEquals(null, emails);
        System.assertEquals(1, emails.size());
    }
}