//creator: Brandon Cochrane, Technical Architect, Salesforce
//date: 2024-06-27
//file: dataweave/setIntegrationStatusObject.dwl
//description: maps the runtime data to an object in Salesforce intended to track the status of an integration, or log errors for triage, maintenance, support and reporting purposes
//usage: by the runData mapping to build the data used by a specific execution of the process
%dw 2.0
output application/java
//leave as application/java as changing the data type can cause issues when loading DateTime values into a system

var endTime = now() >> "UTC"
var runData = vars.runData update {
	case .endTime -> endTime
	case .processingTime -> (endTime - runData.startTime) as Number { "unit": "milliseconds"}
	case .status -> "Complete"
}

---
[{
	"Application_Name__c":Mule::p('app.name'),
	"Correlation_Id__c": correlationId,
	"Data_Source__c": runData.dataSource,
	"Data_Target__c": runData.dataTarget,
	"End_Time__c": now() >> "UTC",
	"Message__c": runData.message,
	"Platform__c": Mule::p('app.platform'),
	"Process_Name__c": Mule::p('app.process.enrollments'),
	"Processing_Time__c": runData.processingTime,
	"Related_Record_Id__c": runData.relatedRecordId,
	"Replay_ID__c": runData.replayId,
	"Salesforce_Record_Id__c": runData.salesforceRecordId,
	"Source_Channel_Id__c": runData.sourceChannelId,
	"Start_Time__c": runData.startTime,
	"Status__c": runData.status,
	"Target_Channel_Id__c": runData.targetChannelId,
	"Integration_Type__c": runData.integrationType
}]
