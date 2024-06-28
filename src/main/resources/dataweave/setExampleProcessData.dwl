//creator: Brandon Cochrane, Technical Architect, Salesforce
//date: 2024-06-27
//file: dataweave/setSampleProcessData.dwl
//description: example mapping to define process, or flow specific information that can be used to maintenance, debugging, support purposes and enhance logging
//usage: by the runData mapping to build the data used by a specific execution of the process
%dw 2.0
output application/json

var defaultMessage = "not-defined"

//it is recommended to define these values using a property file
//this information gets mapped into vars.runData
---
{
	"integrationType": null default defaultMessage,
	"dataTarget": null default defaultMessage,
	"dataSource": null default defaultMessage,
	"processName": null default defaultMessage,
	"sourceEventRelatedRecordId": null default null, //set as the primary key of the event if source event is not from Salesforce
	"salesforceEventRecordId": null default null, //set as the salesforce record Id if one is in the event
	"processDescription": "change to name or description of the process" default defaultMessage,
	"sourceChannelId": null default null, //if event based source, use the name of the channel that publishes the event
	"targetChannelId": null default null, //if the process publishes an event put the name of the channel here
	"replayId": payload.data.event.replayId, //replay Id of event. default configuration payload.data.event.replayId is for a Salesforce platform event
	"processFlags":{ 
		//define any flags that impact processing, routing. 
	}
}