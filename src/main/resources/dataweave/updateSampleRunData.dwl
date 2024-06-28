//creator: Brandon Cochrane, Technical Architect, Salesforce
//date: 2024-06-27
//file: dataweave/updateSampleRunData.dwl
//description: update vars.runData
//usage: at end, or middle a process to ensure state is captured should a failure occur, or logging is needed

%dw 2.0
output application/json

var runData = vars.runData
var endTime = now() >> "UTC"
---
runData update {
	case .endTime -> endTime
	case .processingTime -> (endTime - runData.startDate) as Number { "unit": "milliseconds"}
	case .status -> "Complete"
}