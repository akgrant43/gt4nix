Class {
	#name : #NixOsBootEntry,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-NixOs-Boot'
}

{ #category : #'instance creation' }
NixOsBootEntry class >> file: aFileReference [

	^ self new file: aFileReference
]

{ #category : #accessing }
NixOsBootEntry >> buildDate [
	<return: #Date>

	^ file contents lines
		detect: [ :line | line beginsWith: 'version' ]
		ifFound: [ :line | | commaIndex |
			commaIndex := line indexOf: $,.
			Date readFrom:
				(line copyFrom: commaIndex + 11 to: line size) readStream ]
		ifNone: [ ]
]

{ #category : #accessing }
NixOsBootEntry >> file [
	^ file
]

{ #category : #accessing }
NixOsBootEntry >> file: anObject [
	file := anObject
]

{ #category : #accessing }
NixOsBootEntry >> gtSummaryFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ self summaryAttributes ];
		column: 'Attribute' text: #label;
		column: 'Value' text: #value;
		send: #send
]

{ #category : #accessing }
NixOsBootEntry >> initrd [
	<Return: #String>

	^ file contents lines
		detect: [ :line | line beginsWith: 'initrd' ]
		ifFound: [ :line | line copyFrom: 8 to: line size ]
		ifNone: [ ]
]

{ #category : #accessing }
NixOsBootEntry >> kernelVersion [
	<return: #String>

	^ file contents lines
		detect: [ :line | line beginsWith: 'version' ]
		ifFound: [ :line | | startIndex endIndex |
			startIndex := (line indexOfSubCollection: 'Linux') + 6.
			endIndex := (line indexOf: $,) - 2.
			^ line copyFrom: startIndex to: endIndex ]
		ifNone: [ ]
]

{ #category : #accessing }
NixOsBootEntry >> linux [
	<Return: #String>

	^ file contents lines
		detect: [ :line | line beginsWith: 'linux' ]
		ifFound: [ :line | line copyFrom: 7 to: line size ]
		ifNone: [ ]
]

{ #category : #accessing }
NixOsBootEntry >> machineId [
	<Return: #String>

	^ file contents lines
		detect: [ :line | line beginsWith: 'machine-id' ]
		ifFound: [ :line | line copyFrom: 12 to: line size ]
		ifNone: [ ]
]

{ #category : #accessing }
NixOsBootEntry >> options [
	<Return: #String>

	^ file contents lines
		detect: [ :line | line beginsWith: 'options' ]
		ifFound: [ :line | line copyFrom: 9 to: line size ]
		ifNone: [ ]
]

{ #category : #accessing }
NixOsBootEntry >> printOn: aStream [

	aStream
		<< (self version ifNil: [ '<unknown version> ' ]);
		<< ', built on ';
		<< (self buildDate
			ifNil: [ '<unknown date> ' ]
			ifNotNil: [ :date | date iso8601 ])
]

{ #category : #ui }
NixOsBootEntry >> summaryAttributes [

	^ {
		GtRrSummaryLeafNode
			label: 'Version'
			value: self version
			send: self.
		GtRrSummaryLeafNode
			label: 'Build Date'
			value: self buildDate
			send: self.
		GtRrSummaryLeafNode
			label: 'Kernel Version'
			value: self kernelVersion
			send: self.
		GtRrSummaryLeafNode
			label: 'initrd'
			value: self initrd
			send: self.
		GtRrSummaryLeafNode
			label: 'Options'
			value: self options
			send: self.
		GtRrSummaryLeafNode
			label: 'Machine Id'
			value: self machineId
			send: self.
		GtRrSummaryLeafNode
			label: 'File'
			value: file
			send: self.
	}
]

{ #category : #accessing }
NixOsBootEntry >> title [
	<return: #String>

	^ file contents lines
		detect: [ :line | line beginsWith: 'title' ]
		ifFound: [ :line | line copyFrom: 7 to: line size ]
		ifNone: [ '<Untitled>' ]
]

{ #category : #accessing }
NixOsBootEntry >> version [
	<Return: #String>

	^ file contents lines
		detect: [ :line | line beginsWith: 'version' ]
		ifFound: [ :line | | commaIndex |
			commaIndex := line indexOf: $,.
			line copyFrom: 9 to: commaIndex - 1 ]
		ifNone: [ '<no version info>' ]
]
