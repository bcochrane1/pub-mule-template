%dw 2.0
output application/java
var event = if(isEmpty(vars.sourceEvent)) {"channel":""} else vars.sourceEvent

//This function can be used to determine if the event is a Salesforce platform event or not and build the object accordingly
var setObject = if(!isEmpty(event.channel)) {
    "channelId": event.channel,
	"dataSource": "Salesforce",
	"dataTarget": "",
	"relatedRecordId": null,
	"salesforceRecordId": event.data.payload.ChangeEventHeader.recordIds[0],
	"type": "CDC Event",
	"replayId": event.data.event.replayId
} else {
    "channelId": null,
	"dataSource": "",
	"dataTarget": "",
	"relatedRecordId": null,
	"salesforceRecordId": null,
	"type": "Schedule",
	"replayID": null
}

---
{
    "channelId": event.channel,
	"dataSource": "Salesforce",
	"dataTarget": "HMIS",
	"relatedRecordId": null,
	"salesforceRecordId": event.data.payload.ChangeEventHeader.recordIds[0],
	"type": "CDC Event",
	"replayId": event.data.event.replayId,
	"startTime": now() >> "UTC",
	"endTime": null,
	"message": null,
	"status": "In Progress",
	"isDebug" : vars.isDebug default false
} //++ setObject

