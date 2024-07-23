%dw 2.0
import dataweave::commons
output application/json

//creator: Brandon Cochrane, Technical Architect, Salesforce
//date: 2024-07-23
//file: dataweave/updateSampleRunDataComplete.dwl
//description: update vars.runData
//usage: at end, or middle a process to ensure state is captured should a failure occur, or logging is needed


var runData = vars.runData
var endTime = commons::getNow()
---
runData update {
	case .endTime -> endTime
	case .processingTime -> commons::getDateDiff(endTime,runData.startTime)
	case .status -> Mule::p('process.status.complete')
}