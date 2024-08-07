//creator: Brandon Cochrane, Technical Architect, Salesforce
//date: 2024-07-23
//file: dataweave/commons.dwl
//description: common dataweave functions


//formats datetime values
//https://docs.mulesoft.com/dataweave/latest/dataweave-cookbook-format-dates
fun formatDate(value) = value as String {format: Mule::p('app.format.date')}
fun formatTime(value) = value as String {format: Mule::p('app.format.time')}
fun formatDateTime(value) = value as String {format: Mule::p('app.format.dateTime')}
fun getNow() = now() >> (Mule::p('app.timeZone') default "UTC")
fun getNowFormatted() = formatDateTime(getNow())
fun getDateDiff(endTime, startTime) = getDateDiff(endTime,startTime,Mule::p('app.timeUnit') default "milliseconds")
fun getDateDiff(endTime, startTime, unit) = (endTime - startTime) as Number { "unit": unit}

//defines _metadata values
fun getMetadata() = {
	"appName": Mule::p('domain'),
	"javaVersion": Mule::p('java.version'),
	"environmentId": Mule::p('environment.id'),
	"timestamp": getNow()
} 
//system variables not available without passing values as parameter
//overloaded functions provide flexibility on the data in the metadata object
fun getMetadata(correlationId, attributes) = getMetadata() ++ {
	"correlationId": correlationId,
	"requestPath": attributes.requestPath
}
fun getMetadata(mule, correlationId, attributes) = getMetadata(correlationId, attributes) ++ {
	"muleVersion": mule.version
} 


//removes empty values from input
fun removeEmptyValues(value) = treeFilter((value) -> 
	value match {
        case v is Array| Object | Null | "" -> !isEmpty(v)
        else -> true
    }
)

//filters objects
fun treeFilter(value: Any, predicate: (value:Any) -> Boolean) =
    value  match {
            case object is Object ->  do {
               object mapObject ((value, key, index) -> 
                    (key): treeFilter(value, predicate)
                )
                filterObject ((value, key, index) -> predicate(value))
            }
            case array is Array -> do {
                    array map ((item, index) -> treeFilter(item, predicate))
                                         filter ((item, index) -> predicate(item))                 
            }
            else -> $
    }
    

