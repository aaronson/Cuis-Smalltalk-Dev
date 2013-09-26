'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 25 September 2013 at 1:46:40.203 am'!

!Class methodsFor: 'class variables' stamp: 'NR 9/25/2013 01:32'!
renameSilentlyClassVar: old  to: new
	| oldName newName|
	oldName _ old asSymbol.
	newName _ new asSymbol.
	(classPool includesKey: oldName) ifFalse:
		[self error: oldName , ' is not defined in ', self name].
	self withAllSubclasses asOrderedCollection do:
		[:cls | (cls classVarNames includes: newName) ifTrue:
			[self error: newName , ' is already used in ', cls name]].

	self addClassVarName: newName.
	classPool at: newName put: (classPool at: oldName).
	self class replaceSilently: oldName to: newName.	"replace in text body of all methods"
	self removeClassVarName: oldName.
! !

!Browser methodsFor: 'message functions' stamp: 'NR 9/26/2013 00:27'!
renameMessage
	| oldName newName |
	selectedMessage ifNil: [ ^ self ].
	oldName _ self selectedMessageName.
	newName _ self
		request: 'Please type new message name'
		initialAnswer: oldName.
	newName = '' ifTrue: [ ^ self ].
	newName _ newName asSymbol.
	newName = oldName ifTrue: [ ^ self ].
	Refactor
		refactor: self selectedClassOrMetaClass 
		renameInstanceMethod: oldName
		to: newName.
	self messageListIndex: 0.
	self changed: #messageList.
	self setClassOrganizer.! !

!BrowserWindow methodsFor: 'menu building' stamp: 'NR 9/26/2013 00:13'!
messageListMenu
	"Answer the message-list menu"
	"Changed by emm to include menu-item for breakpoints"

	| aMenu |
	aMenu _ MenuMorph new defaultTarget: self.
	aMenu addList:#(
			('what to show...'				offerWhatToShowMenu)
                	('toggle break on entry'		toggleBreakOnEntry					''		model)
            	-
			('browse full (b)' 				browseMethodFull)
			('browse hierarchy (h)'			browseHierarchy)
			('browse method (O)'			openSingleMessageBrowser)
			('browse protocol (p)'			browseFullProtocol)
			-
			('fileOut'						fileOutMessage							''		model)
			-
			('senders of... (n)'				browseSendersOfMessages)
			('implementors of... (m)'			browseMessages)
			('inheritance (i)'					methodHierarchy)
			('versions (v)'					browseVersions)
			-
			('inst var refs...'					browseInstVarRefs)
			('inst var defs...'				browseInstVarDefs)
			('class var refs...'				browseClassVarRefs)
			('class variables'				browseClassVariables)
			('class refs (N)'					browseClassRefs)
			-
			('remove method (x)'			removeMessage							''		model)
			('rename method' 				renameMessage 						''		model)
			-
			('more...'						openShiftedMessageListMenu)).
	^ aMenu
! !