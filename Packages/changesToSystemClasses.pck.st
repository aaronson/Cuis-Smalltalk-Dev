'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 26 October 2013 at 11:46:13.526 pm'!
!Browser methodsFor: 'message functions' stamp: 'NR 10/26/2013 23:46'!
renameMessage: aScope
	| oldName newName |
	selectedMessage ifNil: [ ^ self ].
	oldName _ self selectedMessageName.
	newName _ self
		request: 'Please type new message name'
		initialAnswer: oldName.
	newName = '' ifTrue: [ ^ self ].
	newName _ newName asSymbol.
	newName = oldName ifTrue: [ ^ self ].
	"self selectedClassOrMetaClass 
		renameMethod: oldName
		to: newName."
	RefactorPerformWindow open: (RefactorModel with: (MethodRenameRefactor forClass: self selectedClassOrMetaClass on: oldName  to: newName with: aScope)).
	self messageListIndex: 0.
	self changed: #messageList.
	self setClassOrganizer.! !

!Browser methodsFor: 'message functions' stamp: 'NR 10/26/2013 21:56'!
renameMessageAllClasses
	self renameMessage: AllScope new.! !

!Browser methodsFor: 'message functions' stamp: 'NR 10/26/2013 21:56'!
renameMessageClass
	self renameMessage: ClassScope new.! !

!Browser methodsFor: 'message functions' stamp: 'NR 10/26/2013 21:57'!
renameMessageClassAndSubclasses
	self renameMessage: ClassAndSubclassScope new.! !

!Browser methodsFor: 'message functions' stamp: 'NR 10/26/2013 21:57'!
renameMessageClassCategory
	self renameMessage: ClassCategoryScope new.! !

!Browser methodsFor: 'message functions' stamp: 'NR 10/26/2013 21:57'!
renameMessageMethodCategory
	self renameMessage: MethodCategoryScope new.! !


!ClassDescription methodsFor: 'instance variables' stamp: 'NR 10/13/2013 21:38'!
replaceInstVarName: oldName  to: newName
	| i |
	(i _ instanceVariables indexOf: oldName) = 0 ifTrue:
		[self error: oldName , ' is not defined in ', self name].
	self allSuperclasses , self withAllSubclasses asOrderedCollection do:
		[:cls | (cls instVarNames includes: newName) ifTrue:
			[self error: newName , ' is already used in ', cls name]].

	instanceVariables replaceFrom: i to: i with: (Array with: newName).! !

!ClassDescription methodsFor: 'instance variables' stamp: 'NR 9/29/2013 20:40'!
replaceSilently: old to: new at: usageSelector
	"Replaces the old selector with the new selector at the specified method"
	| oldName newName  oldCode newCode parser header body|

	oldName _ old asString.
	newName _ new asString.
	oldCode _ self sourceCodeAt: usageSelector.
	"Don't make changes in the method header"
	(parser _ self parserClass new) parseSelector: oldCode.
	header _ oldCode copyFrom: 1 to: (parser endOfLastToken min: oldCode size).
	body _ header size > oldCode size
				ifTrue: ['']
				ifFalse: [oldCode copyFrom: header size+1 to: oldCode size].
	newCode _ header , (body copyReplaceTokens: oldName with: newName).
	newCode ~= oldCode ifTrue:
				[self compile: newCode
					classified: (self organization categoryOfElement: usageSelector)
					notifying: nil].
	self isMeta ifFalse: [
			oldCode _ self comment.
			newCode _ oldCode copyReplaceTokens: oldName with: newName.
			newCode ~= oldCode ifTrue: [
				self comment: newCode]]! !

!ClassDescription methodsFor: 'refactoring' stamp: 'NR 9/30/2013 01:02'!
renameMethod: oldSelector to: newSelector 
	|usages code selwordsOld selwordsNew arguments header newHeader colon| 
	newHeader := ''.
	
	"Find how many keywords are there"
	selwordsOld := oldSelector asString findTokens: ':'.
	selwordsNew := newSelector asString findTokens: ':'.
	(selwordsOld size = selwordsNew size) ifFalse: [RefactoringException new signal: RefactoringException differentKeywordsAmountMessage ].	

	"Obtain the arguments names to use them when replacing the code"
	arguments := (Parser new parse: ( header := self methodHeaderFor: oldSelector) class: self) arguments collect: [:each | each name].
	
	usages := Smalltalk allCallsOn: oldSelector.
	code := self sourceCodeAt: oldSelector.
	
	"Build the new message header"
	arguments isEmpty 
		ifTrue: [ colon := ''. 
			newHeader := newSelector asString.]
		ifFalse: [ colon := ':'.
			 arguments with: selwordsNew do: [:arg :sel | newHeader := newHeader, sel asString,': ',arg,' ']].
		
	"Build the new message text"
	code := newHeader, (code allButFirst: (header size)).
	
	self removeSelector: oldSelector.
	self compile: code.
	
	"Replace the old method name in each of the usages with the new name"
	usages do:[:ref |
		1 to: selwordsOld size do:[:i | 	
			ref actualClass replaceSilently: ((selwordsOld at: i),colon) to: ((selwordsNew at: i),colon) at: ref methodSymbol
			]
		].! !


!Class methodsFor: 'class variables' stamp: 'NR 10/15/2013 00:13'!
replaceClassVarName: old  to: new
	| oldName newName|
	oldName  := old asSymbol.
	newName  := new asSymbol.
	"(classPool includesKey: oldName) ifFalse:
		[self error: oldName , ' is not defined in ', self name].
	self withAllSubclasses asOrderedCollection do:
		[:cls | (cls classVarNames includes: newName) ifTrue:
			[self error: newName , ' is already used in ', cls name]]."

	
	classPool at: newName put: (classPool at: oldName).
! !

!SmalltalkEditor methodsFor: 'menu messages' stamp: 'NR 10/26/2013 19:25'!
renameIt
	| selection newName class |
	self selectWord.
	selection _ self selection asString ifNil: [^morph flash].
	newName _ FillInTheBlankMorph 
		request: 'Please type new variable name'
		initialAnswer: selection.
	class _ self codeProvider selectedClassOrMetaClass.
	(class instVarNames includes: selection) ifTrue:[ ^RefactorPerformWindow open: (RefactorModel with: (InstanceVariableRenameRefactor forClass: class on: selection  to: newName) )].
	(class theNonMetaClass classVarNames includes: selection) ifTrue:[
		^RefactorPerformWindow open: (RefactorModel with: (ClassVariableRenameRefactor forClass: class theNonMetaClass on: selection  to: newName) )].
	^morph flash.
! !

!BrowserWindow methodsFor: 'menu building' stamp: 'NR 10/26/2013 21:53'!
openRenameMessageOptionsMenu
	"Offer the rename message selector-list menu"

	^ self renameMessageOptions popUpInWorld! !

!BrowserWindow methodsFor: 'menu building' stamp: 'NR 10/26/2013 21:49'!
renameMessageOptions
	"Answer the message-list menu"
	"Changed by emm to include menu-item for breakpoints"

	| aMenu |
	aMenu _ (MenuMorph entitled: 'Select scope to use') defaultTarget: self.
	aMenu addList:#(
			('Rename in all classes'			renameMessageAllClasses				''		model)
			('Rename only in class'			renameMessageClass				''		model)
			('Rename only in class and subclasses'			renameMessageClassAndSubclasses				''		model)
			('Rename only in class category'			renameMessageClassCategory				''		model)
			('Rename only in method category'			renameMessageMethodCategory				''		model)
).
	^ aMenu
! !


!Browser methodsFor: 'class functions' stamp: 'NR 10/26/2013 20:31'!
renameClass
	| oldName newName |
	selectedClassName ifNil: [ ^self ].
	oldName _ self selectedClass name.
	newName _ self request: 'Please type new class name' initialAnswer: oldName.
	newName = '' ifTrue: [^ self].  " Cancel returns '' "
	newName _ newName asSymbol.
	newName = oldName ifTrue: [^ self].
	(Smalltalk includesKey: newName)
		ifTrue: [^ self error: newName , ' already exists'].
	(RefactorPerformWindow open: (RefactorModel with: (ClassRenameRefactor forClass: (Smalltalk classNamed: oldName) to: newName)))
	"self changed: #classList.
	self classListIndex: ((systemOrganizer listAtCategoryNamed: selectedSystemCategory) indexOf: newName).]"! !


!ClassDescription methodsFor: 'instance variables' stamp: 'NR 10/13/2013 21:37'!
renameSilentlyInstVar: old  to: new
	| oldName newName |
	oldName _ old asString.
	newName _ new asString.
	self replaceInstVarName: oldName to: newName.
	self replaceSilently: oldName to: newName.	"replace in text body of all methods"! !

!ClassDescription methodsFor: 'instance variables' stamp: 'NR 9/29/2013 20:47'!
replaceSilently: old to: new
	"text-replace any part of a method.  Used for class and pool variables.  Don't touch the header.  Not guaranteed to work if name appears in odd circumstances"
	self withAllSubclasses do: [ :cls | |  sels |
		sels _ cls selectors.
		sels do: [ :sel | 
			self replaceSilently: old to: new at: sel.].]
! !


!Class methodsFor: 'class variables' stamp: 'NR 9/28/2013 01:38'!
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
	self removeClassVarName: oldName.! !


!SmalltalkEditor class methodsFor: 'keyboard shortcut tables' stamp: 'NR 9/26/2013 20:18'!
initializeMenu
	"Initialize the mouseButton2 (right button) pop-up menu and corresponding messages."
	"
	Editor initialize
	"

	menu _ SelectionMenu fromArray: {
		{'Help...'.						#openHelp}.
		#-.
		{'Find...(f)'.						#find}.
		{'Find Again (g)'.				#findAgain}.
		{'Use Selection for Find (j)'.		#setSearchString}.
		#-.
		{'Undo - multiple (z)'.			#undo}.
		{'Redo - multiple (Z)'.			#redo}.
		{'Undo / Redo history'.			#offerUndoHistory}.
		#-.
		{'Copy (c)'.						#copySelection}.
		{'Cut (x)'.						#cut}.
		{'Paste (v)'.						#paste}.
		{'Paste without Format'.		#pasteString}.
		{'Paste...'.						#pasteRecent}.
		#-.
		{'Accept (s)'.					#acceptContents}.
		{'Cancel (l)'.					#cancelEdits}.
		#-.
		{'Smalltalk Options'.			#getMenu2}.
	}.
	menu2 _ SelectionMenu fromArray: {
		{'Do it (d)'.						#doIt}.
		{'Print it (p)'.					#printIt}.
		{'Inspect it (i)'.					#inspectIt}.
		{'Explore it (I)'.					#exploreIt}.
		{'Debug it'.						#debugIt}.
		#-.
		{'Explain'.						#explain}.
		{'Browse it (b)'.					#browseIt}.
		{'Senders of it (n)'.				#sendersOfIt}.
		{'Implementors of it (m)'.		#implementorsOfIt}.
		{'References to it (N)'.			#referencesToIt}.
		{'Rename it'.					#renameIt}.

		#-.
		{'Method Strings with it (E)'.	#methodStringsContainingit}.
		{'Method Source with it'.		#methodSourceContainingIt}.
		{'Class Comments with it'.		#classCommentsContainingIt}.
	}! !


!BrowserWindow methodsFor: 'menu building' stamp: 'NR 10/26/2013 21:51'!
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
			('rename method' 				openRenameMessageOptionsMenu)
			-
			('more...'						openShiftedMessageListMenu)).
	^ aMenu
! !


!Parser methodsFor: 'error correction' stamp: 'NR 10/26/2013 20:44'!
correctSelector: proposedKeyword wordIntervals: spots exprInterval: expInt ifAbort: abortAction
	"Correct the proposedKeyword to some selector symbol, correcting the original text if such action is indicated.  abortAction is invoked if the proposedKeyword couldn't be converted into a valid selector.  Spots is an ordered collection of intervals within the test stream of the for each of the keyword parts."

	| correctSelector userSelection |
	"If we can't ask the user, assume that the keyword will be defined later"
	self interactive ifFalse: [^proposedKeyword asSymbol].

	"If the requestor is of an exotic kind (like a telnet server) we might not be allowed to open a PupUpMenu for querying the user"
	"
	((requestor isKindOf: Editor) or: [ requestor is: #Morph ])
		ifFalse: [ ^ proposedKeyword asSymbol ].
	"

	userSelection _ requestor selectionInterval.
	requestor selectFrom: spots first first to: spots last last.

	correctSelector _ UnknownSelector name: proposedKeyword.
	correctSelector ifNil: [^abortAction value].

	requestor selectInvisiblyFrom: userSelection first to: userSelection last.

	self substituteSelector: correctSelector keywords wordIntervals: spots.
	^(proposedKeyword last ~~ $:
	   and: [correctSelector last == $:])
		ifTrue: [abortAction value]
		ifFalse: [correctSelector]! !

!ClassDescription reorganize!
('initialize-release' doneCompiling obsolete superclass:methodDictionary:format: updateInstances:from:isMeta: updateInstancesFrom:)
('accessing' classVersion comment comment: comment:stamp: hasComment theMetaClass theNonMetaClass)
('copying' copy:from: copy:from:classified: copyAll:from: copyAll:from:classified: copyAllCategoriesFrom: copyCategory:from: copyCategory:from:classified: copyMethodDictionaryFrom:)
('printing' classVariablesString instanceVariablesString printOn: printWithClosureAnalysisOn: sharedPoolsString storeOn:)
('instance variables' addInstVarName: allInstVarNamesEverywhere browseClassVarRefs checkForInstVarsOK: chooseClassVarName chooseInstVarAlphabeticallyThenDo: chooseInstVarThenDo: classThatDefinesClassVariable: classThatDefinesInstanceVariable: forceNewFrom: instVarNameForIndex: instVarNames removeInstVarName: renameInstVar:to: renameSilentlyInstVar:to: replaceInstVarName:to: replaceSilently:to: replaceSilently:to:at:)
('accessing method dictionary' addAndClassifySelector:withMethod:inProtocol:notifying: addSelector:withMethod:notifying: allMethodCategoriesIntegratedThrough: induceMDFault methodsInCategory: recoverFromMDFault recoverFromMDFaultWithTrace removeCategory: removeSelector: removeSelectorIfInBaseSystem: ultimateSourceCodeAt:ifAbsent:)
('organization' category category: organization organization: whichCategoryIncludesSelector: zapOrganization)
('compiling' acceptsLoggingOfCompilation compile:classified: compile:classified:notifying: compile:classified:withStamp:notifying: compile:classified:withStamp:notifying:logSource: compile:notifying: compileSilently:classified: compileSilently:classified:notifying: instVarNamesAndOffsetsDo: moveInstVarNamed:to:after: noteCompilationOf:meta: wantsChangeSetLogging wantsRecompilationProgressReported)
('fileIn/Out' classComment: classComment:stamp: commentFollows commentStamp: commentStamp:prior: definition definitionPreamble fileOutCategory: fileOutCategory:on:moveSource:toFile: fileOutChangedMessages:on: fileOutChangedMessages:on:moveSource:toFile: fileOutMethod: fileOutOn: fileOutOn:moveSource:toFile: fileOutOrganizationOn: methods methodsFor: methodsFor:priorSource:inFile: methodsFor:stamp: methodsFor:stamp:prior: moveChangesTo: printCategoryChunk:on: printCategoryChunk:on:priorMethod: printCategoryChunk:on:withStamp:priorMethod: printCategoryChunk:withStamp:on: printMethodChunk:withPreamble:on:moveSource:toFile: putClassCommentToCondensedChangesFile: reformatAll reformatMethodAt: reorganize)
('private' errorCategoryName instVarMappingFrom: linesOfCode logMethodSource:forMethodWithNode:inCategory:withStamp:notifying: newInstanceFrom:variable:size:map: setInstVarNames:)
('accessing class hierarchy' classesThatImplementAllOf: printSubclassesOn:level: removeUninstantiatedSubclassesSilently subclasses subclassesDo:)
('method dictionary' allMethodsInCategory:)
('system-support' allUnreferencedClassVariables)
('refactoring' renameMethod:to:)
!
!classMoveToSomePackage: #ClassRenameRefactor!
Smalltalk removeClassNamedIfInBaseSystem: #ClassRenameRefactor!
!classMoveToSomePackage: #ClassVariableRenameRefactor!
Smalltalk removeClassNamedIfInBaseSystem: #ClassVariableRenameRefactor!
!classMoveToSomePackage: #DummyRefactor!
Smalltalk removeClassNamedIfInBaseSystem: #DummyRefactor!
!classMoveToSomePackage: #InstanceVariableRenameRefactor!
Smalltalk removeClassNamedIfInBaseSystem: #InstanceVariableRenameRefactor!
!classMoveToSomePackage: #MethodRenameRefactor!
Smalltalk removeClassNamedIfInBaseSystem: #MethodRenameRefactor!
!classMoveToSomePackage: #Refactor!
Smalltalk removeClassNamedIfInBaseSystem: #Refactor!
!classMoveToSomePackage: #RefactorListModel!
Smalltalk removeClassNamedIfInBaseSystem: #RefactorListModel!
!classMoveToSomePackage: #RefactorListWindow!
Smalltalk removeClassNamedIfInBaseSystem: #RefactorListWindow!
!classMoveToSomePackage: #RefactorModel!
Smalltalk removeClassNamedIfInBaseSystem: #RefactorModel!
!classMoveToSomePackage: #RefactorOrganizer!
Smalltalk removeClassNamedIfInBaseSystem: #RefactorOrganizer!
!classMoveToSomePackage: #RefactorWindow!
Smalltalk removeClassNamedIfInBaseSystem: #RefactorWindow!
!classMoveToSomePackage: #RefactoringException!
Smalltalk removeClassNamedIfInBaseSystem: #RefactoringException!
!classMoveToSomePackage: #RefactoringTest!
Smalltalk removeClassNamedIfInBaseSystem: #RefactoringTest!
!classMoveToSomePackage: #Usage!
Smalltalk removeClassNamedIfInBaseSystem: #Usage!
