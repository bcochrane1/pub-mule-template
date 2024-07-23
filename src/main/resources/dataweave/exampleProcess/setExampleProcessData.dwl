%dw 2.0
import dataweave::commons
output application/json

/*
 * //creator: Brandon Cochrane, Technical Architect, Salesforce
 * //date: 2024-06-27
 * //file: dataweave/setSampleProcessData.dwl
 * //description: example mapping to define process, or flow specific information that can be used to maintenance, debugging, support purposes and enhance logging
 * //usage: by the runData mapping to build the data used by a specific execution of the process
 * //it is recommended to define these values using a property file
 * //this information gets mapped into runData variable in the initialize-process-dataFlow
*/

var defaultMessage = "not-defined" default Mule::p('process.defaultMessage')

---
{
	"integrationType": Mule::p('process.example.type') default defaultMessage,
	"dataTarget": Mule::p('process.example.dataTarget') default defaultMessage,
	"dataSource": Mule::p('process.example.dataSource') default defaultMessage,
	"processName": Mule::p('process.example.name') default defaultMessage,
	"sourceEventRelatedRecordId": null default null, //set as the primary key of the event if source event is not from Salesforce
	"salesforceEventRecordId": null default null, //set as the salesforce record Id if one is in the event
	"processDescription": Mule::p('process.example.description') default defaultMessage,
	"sourceChannelId": null default null, //if event based source, use the name of the channel that publishes the event
	"targetChannelId": null default null, //if the process publishes an event put the name of the channel here
	"replayId": payload.data.event.replayId default null, //replay Id of event. default configuration payload.data.event.replayId is for a Salesforce platform event
	"processFlags":{ 
		//define any flags that impact processing, routing. 
	},
	"_metadata": commons::getMetadata()
}