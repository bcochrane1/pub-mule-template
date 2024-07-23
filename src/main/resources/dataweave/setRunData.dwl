//creator: Brandon Cochrane, Technical Architect, Salesforce
//date: 2024-07-23
//file: dataweave/setRunData.dwl
//description: Builds the runData object that is used during a specific execution to track runtime and process related information
//usage: For logging or generation of an object that can be used for support, maintenance and reporting purposes

%dw 2.0
import dataweave::commons
output application/java
var event = vars.sourceEvent

//This function can be used to determine the event and enhance the object accordingly
var setObject = if (false) {
		//any additional fields that may require routing
	} 
	else {
		//any additional fields that may require routing
	}
	
var processData = vars.processData default {}

---
{
	"replayId": event.data.event.replayId default null,
	"startTime": commons::getNow(),
	"endTime": null,//updated as last step of a process
	"processingTime": null, //updated as last step of process using dataweave::commons::getDateDiff(endTime,startTime)
	"timeUnit": Mule::p('app.timeUnit') default "milliseconds",
	"message": null, //processing based messaging
	"status": Mule::p('process.status.inProgress'), //update this field throughout the process to maintain state of an integration
	"isDebug" : vars.debug default false, //can be used as a flag during development, or troubleshooting to modify the behaviour of the application that makes debugging easier
	"description": null, //update this field throughout processing with additional information or error.message when once occurs 
	"processDescription": processData.processDescription,
	"dataTarget": processData.dataTarget,
	"relatedRecordId": processData.sourceEventRelatedRecordId default null,
	"salesforceRecordId": processData.salesforceEventRecordId default null,	
	"integrationType": processData.integrationType default null,
    "sourceChannelId": processData.sourceChannelId default null,
    "targetChannelId": processData.targetChannelId default null
} ++ setObject