@IsTest
public class CSP_MentionUtilsSchedulerTest {
	@IsTest
    private static void verifyMentionUtilsSchedulerWorksWithoutExceptions() {
        CSP_MentionUtilsScheduler scheduler = new CSP_MentionUtilsScheduler();
        String sch = '0 0 23 * * ?';
        Test.startTest();
		system.schedule('Test CSP Scheduler', sch, scheduler);
        Test.stopTest();
    }
}