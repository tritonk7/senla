@isTest
private class SpacePointManagerTest {
    
    @isTest 
    static void testGetSpacePoints() {
        TestDataFactory.createSpacePoint();
        List<Space_Point__c> spacePoint = SpacePointManager.getSpacePoints();
        System.assertEquals(1, spacePoint.size());        
    }
}