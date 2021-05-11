@IsTest
private class SpacePointManagerTest {
    private static List<Space_Point__c> newSpacePoints;
    
    static {
        newSpacePoints = TestDataFactory.createSpacePoints();
    }
    
    @IsTest 
    private static void testGetSpacePoints() {
        List<Space_Point__c> result = SpacePointManager.getSpacePoints();
       
        System.assertNotEquals(null, result);
        System.assertEquals(1, result.size());      
    }
}