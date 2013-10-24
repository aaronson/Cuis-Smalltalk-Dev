'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 13 October 2013 at 9:43:35.297 pm'!
!Browser methodsFor: 'message functions' stamp: 'NR 9/29/2013 23:53'!
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
	self selectedClassOrMetaClass 
		renameMethod: oldName
		to: newName.
	self messageListIndex: 0.
	self changed: #messageList.
	self setClassOrganizer.! !


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

!SmalltalkEditor methodsFor: 'menu messages' stamp: 'NR 9/29/2013 23:48'!
renameIt
	| selection newName class |
	self selectWord.
	selection _ self selection asString ifNil: [^morph flash].
	newName _ FillInTheBlankMorph 
		request: 'Please type new variable name'
		initialAnswer: selection.
	class _ self codeProvider selectedClassOrMetaClass.
	(class instVarNames includes: selection) ifTrue:[ ^class renameSilentlyInstVar: selection to: newName].
	(class theNonMetaClass classVarNames includes: selection) ifTrue:[^ class theNonMetaClass renameSilentlyClassVar: selection to: newName].
	^morph flash.
! !


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

