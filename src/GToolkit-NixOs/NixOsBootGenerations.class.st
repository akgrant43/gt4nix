Class {
	#name : #NixOsBootGenerations,
	#superclass : #Object,
	#instVars : [
		'entriesDirectory',
		'entries'
	],
	#category : #'GToolkit-NixOs-Boot'
}

{ #category : #accessing }
NixOsBootGenerations >> entries [

	^ entries ifNil: [ entries := self getEntries ]
]

{ #category : #accessing }
NixOsBootGenerations >> entriesDirectory [
	^ entriesDirectory
]

{ #category : #accessing }
NixOsBootGenerations >> entriesDirectory: anObject [
	entriesDirectory := anObject
]

{ #category : #private }
NixOsBootGenerations >> getEntries [
	| newEntries |

	newEntries := (entriesDirectory childrenMatching: '*.conf') collect: [ :child |
		NixOsBootEntry file: child ].
	^ newEntries sorted: #version descending.
]

{ #category : #ui }
NixOsBootGenerations >> gtEntriesFor: aView [
	<gtView>

	^ aView list
		title: 'Entries';
		priority: 10;
		items: [ self entries ]
]

{ #category : #accessing }
NixOsBootGenerations >> initialize [

	super initialize.
	entriesDirectory := '/boot/loader/entries' asFileReference.
]
