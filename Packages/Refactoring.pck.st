'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 27 October 2013 at 7:31:34.924 pm'!
'Description '!
!provides: 'Refactoring' 1 26!
!classDefinition: #RefactorListModel category: #'Refactoring-GUI'!
ActiveModel subclass: #RefactorListModel
	instanceVariableNames: 'refactors selection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-GUI'!
!classDefinition: 'RefactorListModel class' category: #'Refactoring-GUI'!
RefactorListModel class
	instanceVariableNames: ''!

!classDefinition: #RefactorModel category: #'Refactoring-GUI'!
ActiveModel subclass: #RefactorModel
	instanceVariableNames: 'selection refactor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-GUI'!
!classDefinition: 'RefactorModel class' category: #'Refactoring-GUI'!
RefactorModel class
	instanceVariableNames: ''!

!classDefinition: #RefactoringException category: #Refactoring!
Error subclass: #RefactoringException
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'RefactoringException class' category: #Refactoring!
RefactoringException class
	instanceVariableNames: ''!

!classDefinition: #RefactorListWindow category: #'Refactoring-GUI'!
SystemWindow subclass: #RefactorListWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-GUI'!
!classDefinition: 'RefactorListWindow class' category: #'Refactoring-GUI'!
RefactorListWindow class
	instanceVariableNames: ''!

!classDefinition: #RefactorWindow category: #'Refactoring-GUI'!
SystemWindow subclass: #RefactorWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-GUI'!
!classDefinition: 'RefactorWindow class' category: #'Refactoring-GUI'!
RefactorWindow class
	instanceVariableNames: ''!

!classDefinition: #RefactorPerformWindow category: #'Refactoring-GUI'!
RefactorWindow subclass: #RefactorPerformWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-GUI'!
!classDefinition: 'RefactorPerformWindow class' category: #'Refactoring-GUI'!
RefactorPerformWindow class
	instanceVariableNames: ''!

!classDefinition: #Refactor category: #Refactoring!
Object subclass: #Refactor
	instanceVariableNames: 'oldName newName usages'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'Refactor class' category: #Refactoring!
Refactor class
	instanceVariableNames: ''!

!classDefinition: #ClassRenameRefactor category: #Refactoring!
Refactor subclass: #ClassRenameRefactor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'ClassRenameRefactor class' category: #Refactoring!
ClassRenameRefactor class
	instanceVariableNames: ''!

!classDefinition: #ClassVariableRenameRefactor category: #Refactoring!
Refactor subclass: #ClassVariableRenameRefactor
	instanceVariableNames: 'class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'ClassVariableRenameRefactor class' category: #Refactoring!
ClassVariableRenameRefactor class
	instanceVariableNames: ''!

!classDefinition: #InstanceVariableRenameRefactor category: #Refactoring!
Refactor subclass: #InstanceVariableRenameRefactor
	instanceVariableNames: 'class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'InstanceVariableRenameRefactor class' category: #Refactoring!
InstanceVariableRenameRefactor class
	instanceVariableNames: ''!

!classDefinition: #MethodRenameRefactor category: #Refactoring!
Refactor subclass: #MethodRenameRefactor
	instanceVariableNames: 'class arguments oldHeader'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'MethodRenameRefactor class' category: #Refactoring!
MethodRenameRefactor class
	instanceVariableNames: ''!

!classDefinition: #RefactorOrganizer category: #Refactoring!
Object subclass: #RefactorOrganizer
	instanceVariableNames: 'refactors lastUndoneRefactor'
	classVariableNames: 'Instance'
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'RefactorOrganizer class' category: #Refactoring!
RefactorOrganizer class
	instanceVariableNames: ''!

!classDefinition: #Scope category: #'Refactoring-Scope'!
Object subclass: #Scope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-Scope'!
!classDefinition: 'Scope class' category: #'Refactoring-Scope'!
Scope class
	instanceVariableNames: ''!

!classDefinition: #AllScope category: #'Refactoring-Scope'!
Scope subclass: #AllScope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-Scope'!
!classDefinition: 'AllScope class' category: #'Refactoring-Scope'!
AllScope class
	instanceVariableNames: ''!

!classDefinition: #ClassAndSubclassScope category: #'Refactoring-Scope'!
Scope subclass: #ClassAndSubclassScope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-Scope'!
!classDefinition: 'ClassAndSubclassScope class' category: #'Refactoring-Scope'!
ClassAndSubclassScope class
	instanceVariableNames: ''!

!classDefinition: #ClassCategoryScope category: #'Refactoring-Scope'!
Scope subclass: #ClassCategoryScope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-Scope'!
!classDefinition: 'ClassCategoryScope class' category: #'Refactoring-Scope'!
ClassCategoryScope class
	instanceVariableNames: ''!

!classDefinition: #ClassScope category: #'Refactoring-Scope'!
Scope subclass: #ClassScope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-Scope'!
!classDefinition: 'ClassScope class' category: #'Refactoring-Scope'!
ClassScope class
	instanceVariableNames: ''!

!classDefinition: #MethodCategoryScope category: #'Refactoring-Scope'!
Scope subclass: #MethodCategoryScope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring-Scope'!
!classDefinition: 'MethodCategoryScope class' category: #'Refactoring-Scope'!
MethodCategoryScope class
	instanceVariableNames: ''!

!classDefinition: #RefactoringTest category: #Refactoring!
TestCase subclass: #RefactoringTest
	instanceVariableNames: 'testClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'RefactoringTest class' category: #Refactoring!
RefactoringTest class
	instanceVariableNames: ''!

!classDefinition: #Usage category: #Refactoring!
Object subclass: #Usage
	instanceVariableNames: 'methodRef oldCode newCode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'Usage class' category: #Refactoring!
Usage class
	instanceVariableNames: ''!


!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 22:54'!
browseRefactor
	selection ifNotNil: [RefactorWindow open: (RefactorModel with: (refactors at: self selectionIndex ) ).]! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:28'!
clear
	RefactorOrganizer instance clear ! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/22/2013 01:52'!
initialize
	self updateRefactors.
	RefactorOrganizer instance when: #refactorListModified send: #updateRefactors to:self.
	! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:35'!
lastUndoneText
	|lastUndone| 
	(lastUndone := RefactorOrganizer instance lastUndoneRefactor) ifNil: [^'No refactor to redo'].
	^lastUndone class asString, ': ', lastUndone oldName, ' ->> ', lastUndone newName.! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 16:51'!
redo
	RefactorOrganizer instance redo ! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/22/2013 01:15'!
refactors
	^refactors collect: [:ref | ref class asString, ': ', ref oldName, ' ->> ', ref newName.] ! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/20/2013 19:52'!
selection
	^selection! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/20/2013 19:53'!
selectionIndex
	^ refactors indexOf: selection! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/20/2013 19:54'!
selectionIndex: anInteger

	selection _ anInteger = 0 ifFalse: [ refactors at: anInteger ].! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/24/2013 00:19'!
undo
	selection ifNotNil: [RefactorOrganizer instance undo: selection.].
	self updateRefactors ! !

!RefactorListModel methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:33'!
updateRefactors
	refactors := RefactorOrganizer instance refactors.
	self changed: #refactors.
	self changed: #lastUndoneText! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 22:51'!
newCodeSelected

	selection ifNil: [ ^'' ].
	^selection newCode.! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 22:49'!
oldCodeSelected

	selection ifNil: [ ^'' ].
	^selection oldCode.! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 16:48'!
performRefactor
	refactor perform.! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 20:33'!
removeUsage
	refactor usages remove: selection.
	self changed: #usages.
	self selectionIndex: 0.! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 21:05'!
selection
	^ selection! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:09'!
selectionIndex
	^ refactor usages indexOf: selection! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:09'!
selectionIndex: anInteger

	selection _ anInteger = 0 ifFalse: [ refactor usages at: anInteger ].
	self changed: #oldCodeSelected.
	self changed: #newCodeSelected.
! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:09'!
usages
	^refactor usages collect: [:usg | usg classRef asString, ': ', usg methodSymbol]! !

!RefactorModel methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:09'!
withRefactor: ref
	refactor := ref.! !

!RefactorModel class methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:09'!
with: refactor
	^self new withRefactor: refactor! !

!RefactoringException class methodsFor: 'as yet unclassified' stamp: 'NR 9/30/2013 00:17'!
differentKeywordsAmountMessage
	^'The new name should contain the same amount of keywords as the old method name'! !

!RefactorListWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:48'!
buildMorphicWindow
	 |refactorList upperRow buttonRow undoButton redoButton exploreButton clearButton lastUndoRow lastUndoText | 
	
	refactorList := PluggableListMorph 
		model: model
		listGetter: #refactors 
		indexGetter: #selectionIndex
		indexSetter: #selectionIndex:.
	upperRow := LayoutMorph newRow.
	upperRow addMorph: refactorList.
	
	undoButton _ PluggableButtonMorph model: model action: #undo label: 'Undo Refactor'.
	exploreButton _ PluggableButtonMorph model: model action: #browseRefactor label: 'Browse Refactor'.
	redoButton _ PluggableButtonMorph model: model action: #redo label: 'Redo Last Undone Refactor'.
	clearButton _ PluggableButtonMorph model: model action: #clear label: 'Clear Refactor List'.
	
	lastUndoText := TextModelMorph 
		textProvider: model
		textGetter: #lastUndoneText .
				.
	lastUndoRow := LayoutMorph newRow.
	lastUndoRow addMorph: lastUndoText.
	
	buttonRow _ LayoutMorph newRow.
	buttonRow
		color: self widgetsColor quiteWhiter;
		addMorph: undoButton proportionalWidth: 0.6;
		addMorph: exploreButton proportionalWidth: 0.6;
		addMorph: redoButton proportionalWidth: 0.6;
		addMorph: clearButton proportionalWidth: 0.6.

	self layoutMorph
		addMorph: upperRow proportionalHeight: 0.8;
		addAdjusterAndMorph: lastUndoRow proportionalHeight: 0.1;
		addAdjusterAndMorph: buttonRow proportionalHeight: 0.1.
	self setUpdatablePanesFrom: #(#refactors).
	self setLabel: 'Refactor Organizer'! !

!RefactorListWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:53'!
windowColor
	^Color blue quiteWhiter! !

!RefactorWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:05'!
buildMorphicWindow
	 | upperRow middleRow lowerRow | 
	upperRow := self buildUsagesListRow.
	middleRow := self buildOldCodeRow.
	lowerRow  := self buildNewCodeRow.
	
	self layoutMorph
		addMorph: upperRow proportionalHeight: 0.3;
		addAdjusterAndMorph: middleRow proportionalHeight: 0.3;
		addAdjusterAndMorph: lowerRow proportionalHeight: 0.3.
	self setUpdatablePanesFrom: #(#usages).
	self setLabel: 'Method changes'! !

!RefactorWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:04'!
buildNewCodeRow
	| lowerRow newCode |
	newCode := TextModelMorph 
		textProvider: model
		textGetter: #newCodeSelected. 
		
	lowerRow := LayoutMorph newRow.
	lowerRow addMorph: newCode.
	^lowerRow
	! !

!RefactorWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:02'!
buildOldCodeRow
	| middleRow oldCode |
	oldCode := TextModelMorph 
		textProvider: model
		textGetter: #oldCodeSelected .
				.
	middleRow := LayoutMorph newRow.
	middleRow addMorph: oldCode.
	^middleRow ! !

!RefactorWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/25/2013 00:02'!
buildUsagesListRow
	|usagesList row|
	usagesList := PluggableListMorph 
		model: model
		listGetter: #usages 
		indexGetter: #selectionIndex
		indexSetter: #selectionIndex:.
	row := LayoutMorph newRow.
	row addMorph: usagesList.
	^row! !

!RefactorWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:53'!
windowColor
	^Color red quiteWhiter! !

!RefactorPerformWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 19:28'!
buildMorphicWindow
	 | upperRow middleRow lowerRow buttonRow performButton removeButton cancelButton | 
	upperRow := self buildUsagesListRow.
	middleRow := self buildOldCodeRow.
	lowerRow  := self buildNewCodeRow.
	
	removeButton _ PluggableButtonMorph model: model action: #removeUsage label: 'Remove Usage'.
	performButton _ PluggableButtonMorph model: self action: #performRefactor label: 'Perform Refactor'.
	cancelButton _ PluggableButtonMorph model: self action: #cancelRefactor label: 'Cancel Refactor'.

	
	buttonRow _ LayoutMorph newRow.
	buttonRow
		color: self widgetsColor quiteWhiter;
		addMorph: removeButton proportionalWidth: 0.33;
		addMorph: performButton proportionalWidth: 0.33;
		addMorph: cancelButton proportionalWidth: 0.33.

	
	self layoutMorph
		addMorph: upperRow proportionalHeight: 0.3;
		addAdjusterAndMorph: middleRow proportionalHeight: 0.3;
		addAdjusterAndMorph: lowerRow proportionalHeight: 0.3;
		addAdjusterAndMorph: buttonRow proportionalHeight: 0.1.

	self setUpdatablePanesFrom: #(#usages).
	self setLabel: 'Select methods to perform rename on'! !

!RefactorPerformWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 20:00'!
cancelRefactor
	self delete.
	^false.! !

!RefactorPerformWindow methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 16:34'!
performRefactor
	model performRefactor.
	self delete.! !

!Refactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:19'!
newName
	^newName! !

!Refactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:19'!
oldName
	^oldName! !

!Refactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:55'!
perform
	RefactorOrganizer instance addRefactor: self.! !

!Refactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:18'!
undo
	self subclassResponsibility.! !

!Refactor methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 22:55'!
usages
	^usages! !

!ClassRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 20:29'!
initializeForClass: aClass to: aNewClassName

	oldName := aClass name.
	newName := aNewClassName .
	usages := OrderedCollection new.

	(Smalltalk allCallsOn: (Smalltalk associationAt: oldName))
		do:[ :usg | 
			usages add: (Usage on: usg replace: oldName with: newName)
			].! !

!ClassRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:55'!
perform
	(Smalltalk classNamed: oldName) rename: newName.
	usages do: [:usg | usg perform].
	super perform.! !

!ClassRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/18/2013 00:37'!
undo
	(Smalltalk classNamed: newName) rename: oldName.
	usages do: [:usg | usg undo].! !

!ClassRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:00'!
forClass: aClassName to: aNewName
	^self new initializeForClass: aClassName to: aNewName! !

!ClassVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'Aa 10/24/2013 00:16'!
initializeForClass: aClass on: anOldMethodName to: aNewMethodName
	|meta|
	class := aClass.
	oldName := anOldMethodName.
	newName := aNewMethodName.
	meta:= class class.
	usages := OrderedCollection new.
     (class classVarNames includes: oldName)
		ifFalse: [RefactoringException new signal: oldName , '  is not defined in the class'].
	meta withAllSubclasses do: [ :cls | |  sels |
		sels _ cls selectors.
		sels do: [ :sel | ((meta sourceCodeAt: sel) includesSubString: oldName) ifTrue:[
				usages add: (Usage on: (MethodReference class: meta selector: sel) replace: oldName with: newName)
				]
			]
		].! !

!ClassVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:56'!
perform
 	"TODO check for exceptions" 
	class addClassVarName: newName.
	class replaceClassVarName: oldName to: newName.
	usages do: [:usg | usg perform].
	class removeClassVarName: oldName.
	super perform.! !

!ClassVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/18/2013 01:04'!
undo
 	"TODO check for exceptions" 
	class addClassVarName: oldName.
	class replaceClassVarName: newName to: oldName.
	usages do: [:usg | usg undo].
	class removeClassVarName: newName.! !

!ClassVariableRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:01'!
forClass: aClassName on: anOldVarName to: aNewVarName
	^self new initializeForClass: aClassName on: anOldVarName to: aNewVarName! !

!InstanceVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'Aa 10/24/2013 00:15'!
initializeForClass: aClass on: anOldMethodName to: aNewMethodName
	
	class := aClass.
	oldName := anOldMethodName.
	newName := aNewMethodName.
	
	usages := OrderedCollection new.
	"Find how many keywords are there"
	
	(class instVarNames includes: oldName)
		ifFalse: [RefactoringException new signal: oldName , '  is not defined in the class'].
	class withAllSubclasses do: [ :cls | |  sels |
		
		sels _ cls selectors.
		
		
		sels do: [ :sel | ((class sourceCodeAt: sel) includesSubString: oldName) ifTrue:[
				
				usages add: (Usage on: (MethodReference class: class selector: sel) replace: oldName with: newName)
				]
			]
		].
 
! !

!InstanceVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:56'!
perform
	class replaceInstVarName: oldName to: newName.
	usages do: [:usg | usg perform].
	super perform.! !

!InstanceVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/18/2013 01:05'!
undo
	class replaceInstVarName: newName to: oldName.
	usages do: [:usg | usg undo]! !

!InstanceVariableRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:00'!
forClass: aClassName on: anOldVarName to: aNewVarName
	^self new initializeForClass: aClassName on: anOldVarName to: aNewVarName! !

!MethodRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:25'!
initializeForClass: aClass on: anOldMethodName to: aNewMethodName withScope: aScope
	| selwordsOld selwordsNew reference| 
	class := aClass.
	oldName := anOldMethodName.
	newName := aNewMethodName.
	
	(class canUnderstand: oldName)
		ifFalse: [RefactoringException new signal: oldName , ' is not defined in the class'].

	"Find how many keywords are there"
	selwordsOld := oldName asString findTokens: ':'.
	selwordsNew := newName asString findTokens: ':'.
	(selwordsOld size = selwordsNew size) ifFalse: [RefactoringException new signal: RefactoringException differentKeywordsAmountMessage ].	
	
	reference := MethodReference class: class selector: oldName.
	usages :=((Smalltalk allCallsOn: anOldMethodName asSymbol) select: [:newref | aScope is: newref inScopeOf: reference]) collect: [:usg | Usage on: usg replaceCollection: selwordsOld with: selwordsNew].! !

!MethodRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:56'!
perform
	| code selwordsNew  newHeader | 

	newHeader := ''.
	selwordsNew := newName asString findTokens: ':'.
	
	"Obtain the arguments names to use them when replacing the code"
	arguments := (Parser new parse: ( oldHeader := class methodHeaderFor: oldName) class: class) arguments collect: [:each | each name].
	code := class sourceCodeAt: oldName.	
	
	"Build the new message header"
	arguments isEmpty 
		ifTrue: [ newHeader := newName asString.]
		ifFalse: [ arguments with: selwordsNew do: [:arg :sel | newHeader := newHeader, sel asString,': ',arg,' ']].
		
	"Build the new message text"
	code := newHeader, (code allButFirst: (oldHeader size)).
	
	class removeSelector: oldName.
	class compile: code.
	
	"Replace the old method name in each of the usages with the new name"
	usages do:[:usg | usg perform.].
	
	super perform.! !

!MethodRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/18/2013 01:34'!
undo
	| code | 

	code := class sourceCodeAt: newName.	
		
	"Build the new message text"
	code := oldHeader, (code allButFirst: ((class methodHeaderFor: newName) size)).
	
	class removeSelector: newName.
	class compile: code.
	
	"Replace the old method name in each of the usages with the new name"
	usages do:[:usg | usg undo.]! !

!MethodRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:03'!
forClass: aClassName on: anOldMethodName to: aNewMethodName
	^self new initializeForClass: aClassName on: anOldMethodName to: aNewMethodName withScope: AllScope new! !

!MethodRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 17:54'!
forClass: aClassName on: anOldMethodName to: aNewMethodName with: aScope
	^self new initializeForClass: aClassName on: anOldMethodName to: aNewMethodName withScope: aScope! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/24/2013 00:21'!
addRefactor: aRefactor
	refactors addFirst: aRefactor.
	self triggerEvent: #refactorListModified.! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:06'!
clear
	1 to: refactors size do:[:each | refactors removeLast ].
	lastUndoneRefactor := nil.
	self triggerEvent: #refactorListModified! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:37'!
initialize
	refactors := OrderedCollection new.
	lastUndoneRefactor := nil.! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 18:32'!
lastUndoneRefactor
	^lastUndoneRefactor ! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/27/2013 19:31'!
redo
	"ver que no sea dummy"
	lastUndoneRefactor isNil ifFalse:[
		lastUndoneRefactor perform.].
	lastUndoneRefactor := nil ! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 20:14'!
refactors
	^refactors! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/22/2013 01:52'!
undo: aRefactor

	(refactors includes: aRefactor) ifFalse: [RefactoringException new signal: 'Unrecognized refactor'].
	aRefactor undo.
	lastUndoneRefactor := aRefactor.
	1 to: (refactors indexOf: aRefactor) do: [:a | refactors removeFirst.].
	self triggerEvent: #refactorListModified.! !

!RefactorOrganizer class methodsFor: 'as yet unclassified' stamp: 'NR 10/21/2013 00:47'!
instance
	Instance isNil ifTrue: [^Instance := self new].
	^Instance! !

!Scope methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:26'!
is: reference inScopeOf: originalMethodRef 
	self subclassResponsibility ! !

!AllScope methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:28'!
is: reference inScopeOf: originalMethodRef 
	^true! !

!ClassAndSubclassScope methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:28'!
is: reference inScopeOf: originalMethodRef 
	^ reference actualClass inheritsFrom: originalMethodRef actualClass! !

!ClassCategoryScope methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:27'!
is: reference inScopeOf: originalMethodRef 
	^ reference actualClass category = originalMethodRef actualClass category! !

!ClassScope methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:27'!
is: reference inScopeOf: originalMethodRef 
	^ reference actualClass = originalMethodRef actualClass! !

!MethodCategoryScope methodsFor: 'as yet unclassified' stamp: 'NR 10/26/2013 18:26'!
is: reference inScopeOf: originalMethodRef 
	^ reference category = originalMethodRef category! !

!RefactoringTest methodsFor: 'Running' stamp: 'Aa 10/27/2013 18:02'!
setUp
	super setUp.
	testClass := Object subclass: #TestClass instanceVariableNames: 'varOne' classVariableNames: 'ClassVarOne'  poolDictionaries: '' category: 'Refactoring'.
	testClass class addInstVarName: 'cinvar'.
	RefactorOrganizer instance clear
	! !

!RefactoringTest methodsFor: 'Running' stamp: 'NR 9/19/2013 21:31'!
tearDown
	testClass removeFromSystem! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/26/2013 18:30'!
test01shouldRenameNonUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	(InstanceVariableRenameRefactor  forClass: testClass on: 'varOne' to: 'renamed')perform.
	"	testClass renameSilentlyInstVar: 'varOne' to: 'renamed'."
	self assert: (testClass instanceVariablesString = 'renamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 20:55'!
test02shouldRenameNonUsedClassVariable.
	self assert: (testClass classVariablesString = 'ClassVarOne').
	(ClassVariableRenameRefactor forClass:testClass on: 'ClassVarOne' to: 'Renamed') perform.
	self assert: (testClass classVariablesString = 'Renamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/23/2013 01:01'!
test03shouldRenameUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	testClass compile: 'useInstVar varOne := 3. ^varOne'.
	(InstanceVariableRenameRefactor forClass:testClass on: 'varOne' to: 'renamed') perform.

"	testClass renameSilentlyInstVar: 'varOne' to: 'renamed'."
	self assert: (testClass instanceVariablesString = 'renamed').
	self assert: (testClass new useInstVar = 3).
	self assert: ((testClass sourceCodeAt: #useInstVar) = 'useInstVar renamed := 3. ^renamed')! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 00:48'!
test04shouldRenameUsedClassVariable.

	self assert: (testClass classVariablesString = 'ClassVarOne').
	testClass class compile: 'newMethod ClassVarOne := 42. ^ClassVarOne'.
	(ClassVariableRenameRefactor forClass:testClass on: 'ClassVarOne' to: 'Renamed') perform.

	"testClass renameSilentlyClassVar:'ClassVarOne' to: 'Renamed'."
	self assert: (testClass classVariablesString = 'Renamed').
	self assert: (testClass newMethod = 42).
	self assert: (testClass class  sourceCodeAt: #newMethod) = 'newMethod Renamed := 42. ^Renamed'.! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 00:50'!
test05shouldRenameNonUsedInstanceMethod
	| oldMethodName|
	oldMethodName := 'methodT','oRename'.
 
	testClass compile: (oldMethodName,' ^12').
	self assert: (testClass selectors includes: oldMethodName asSymbol).
	self deny: (testClass selectors includes: #iWasRenamed).
	(MethodRenameRefactor forClass:testClass on: oldMethodName asSymbol to: #iWasRenamed) perform.

"	testClass renameMethod: oldMethodName asSymbol to: #iWasRenamed."
	self deny: (testClass selectors includes: oldMethodName asSymbol).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 21:00'!
test06shouldRenameNonUsedInstanceMethodWithMultipleKeywords
	| kw1 kw2 kw3 symbol|
	kw1 := 'thisI','sAMethod:'.
	kw2 := 'tha','tUses:'.
	kw3 := 'multip','leParameters:'.
	symbol := (kw1,kw2,kw3) asSymbol.
	testClass compile: kw1,' firstPar ',kw2,' secondPar ',kw3,' thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass selectors includes: symbol).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	
	(MethodRenameRefactor forClass:testClass on: symbol asSymbol to: #andNow:hasNew:keywordNames:) perform.

"	testClass renameMethod: symbol to: #andNow:hasNew:keywordNames:."
	self deny: (testClass selectors includes: symbol).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 21:00'!
test07shouldRenameUsedInstanceMethod
	| oldMethodName|
	oldMethodName := 'instMetho','dToRename'.
	testClass compile: oldMethodName ,' ^12'.
	testClass compile: 'newMethod ^self methodToRename'.
	self assert: (testClass selectors includes: oldMethodName asSymbol).
	self deny: (testClass selectors includes: #iWasRenamed).
	
	(MethodRenameRefactor forClass:testClass on: oldMethodName asSymbol to: #iWasRenamed) perform.

	"testClass renameMethod:  oldMethodName asSymbol to: #iWasRenamed."
	self deny: (testClass selectors includes: oldMethodName asSymbol).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 21:01'!
test08shouldRenameUsedInstanceMethodWithMultipleKeywords
	| kw1 kw2 kw3 symbol|
	kw1 := 'thisUse','dMethod:'.
	kw2 := 'isT','aking:'.
	kw3 := 'threeDi','ffParams:'.
	symbol := (kw1,kw2,kw3) asSymbol.
	testClass compile: kw1, ' firstPar ',kw2, ' secondPar ',kw3,' thirdPar ^firstPar + secondPar + thirdPar'.
	testClass compile: 'newMethod ^self ',kw1,'1 ',kw2,'2 ',kw3,'3'.
	self assert: (testClass selectors includes: symbol).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	(MethodRenameRefactor forClass:testClass on: symbol asSymbol to: #andNow:hasNew:keywordNames:) perform.

"	testClass renameMethod: symbol to: #andNow:hasNew:keywordNames:."
	self deny: (testClass selectors includes: symbol).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 01:23'!
test09shouldRenameNonUsedClassInstanceVariable
	self assert: (testClass class instanceVariablesString = 'cinvar').
	(InstanceVariableRenameRefactor forClass:testClass class on: 'cinvar'  to: 'cvrenamed') perform.

	"testClass class renameSilentlyInstVar: 'cinvar' to: 'cvrenamed'."
	self assert: (testClass class instanceVariablesString = 'cvrenamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 01:25'!
test10shouldRenameUsedClassInstanceVariable
	self assert: (testClass class instanceVariablesString = 'cinvar').
	testClass class compile: 'useCIV cinvar := 23. ^cinvar'.
	(InstanceVariableRenameRefactor forClass:testClass class on: 'cinvar'  to: 'cvrenamed') perform.

"	testClass class renameSilentlyInstVar: 'cinvar' to: 'cvrenamed'."
	self assert: (testClass class instanceVariablesString = 'cvrenamed').
	self assert: (testClass useCIV = 23).
	self assert: ((testClass class sourceCodeAt: #useCIV) =   'useCIV cvrenamed := 23. ^cvrenamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 01:26'!
test11shouldRenameNonUsedClassMethod
	| oldMethodName|
	oldMethodName := 'classMetho','dToRename'.
	testClass class compile: oldMethodName ,' ^2+3'.
	self assert: (testClass class selectors includes: oldMethodName asSymbol ).
	self deny: (testClass class selectors includes: #methodRenamed).
	(MethodRenameRefactor forClass:testClass class on: oldMethodName asSymbol  to: #methodRenamed) perform.

"	testClass class renameMethod: oldMethodName asSymbol to: #methodRenamed."
	self deny: (testClass class selectors includes: oldMethodName asSymbol ).
	self assert: (testClass class selectors includes: #methodRenamed).
	self assert: (testClass class sourceCodeAt: #methodRenamed) = 'methodRenamed ^2+3'.
	self assert: (testClass methodRenamed = 5).! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 01:27'!
test12shouldRenameNonUsedClassMethodWithMultipleKeywords
	| kw1 kw2 kw3 symbol|
	kw1 := 'thisIsACla','ssMethod:'.
	kw2 := 'thatI','sUsing:'.
	kw3 := 'manyPar','ameters:'.
	symbol := (kw1,kw2,kw3) asSymbol.
	testClass class compile: kw1, ' firstPar ',kw2, ' secondPar ',kw3,' thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass class selectors includes: symbol).
	self deny: (testClass class selectors includes: #theClassMethod:hasBeen:renamedAllKeywords:).
	(MethodRenameRefactor forClass:testClass class on:  symbol  to: #theClassMethod:hasBeen:renamedAllKeywords:) perform.

"	testClass class renameMethod: symbol to: #theClassMethod:hasBeen:renamedAllKeywords:."
	self deny: (testClass class selectors includes: symbol).
	self assert: (testClass class selectors includes: #theClassMethod:hasBeen:renamedAllKeywords:).
	self assert: (testClass class sourceCodeAt: #theClassMethod:hasBeen:renamedAllKeywords:) = 'theClassMethod: firstPar hasBeen: secondPar renamedAllKeywords: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass theClassMethod: 3 hasBeen: 4 renamedAllKeywords: 5) = 12).! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 01:41'!
test13shouldRenameUsedClassMethod
	|tclass oldMethodName|
	tclass := testClass class .
	oldMethodName := 'classMethodToUse'.
	testClass class compile: oldMethodName , ' ^9'.
	tclass compile: 'methodThatUsed ^self ',oldMethodName .
	self assert: (tclass selectors includes: oldMethodName asSymbol ).
	self deny: (tclass selectors includes: #afterRenaming).
	(MethodRenameRefactor forClass: tclass on: oldMethodName asSymbol  to: #afterRenaming) perform.

"	tclass renameMethod: oldMethodName asSymbol to: #afterRenaming."
	self deny: (tclass selectors includes: oldMethodName asSymbol).
	self assert: (tclass selectors includes: #afterRenaming).
	self assert: (tclass sourceCodeAt: #afterRenaming) = 'afterRenaming ^9'.
	self assert: (testClass afterRenaming = 9).! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/22/2013 01:48'!
test14shouldRenameUsedClassMethodWithMultipleKeywords
	|tclass kw1 kw2 kw3 symbol|
	kw1 := 'iAmU','sing:'.
	kw2 := 'threeDif','ferent:'.
	kw3 := 'keywordsCla','ssMethod:'.
	symbol := (kw1,kw2,kw3) asSymbol.
	tclass := testClass class.
	tclass compile: kw1, ' firstPar ',kw2, ' secondPar ',kw3,' thirdPar ^firstPar + secondPar + thirdPar'.
	tclass compile: 'userMethod ^self ',kw1,' 10 ',kw2,' 20 ',kw3,' 30'.
	self assert: (tclass selectors includes: symbol).
	self deny: (tclass selectors includes: #renamedBut:stillTakes:threeParams:).
	(MethodRenameRefactor forClass: tclass on:  symbol  to: #renamedBut:stillTakes:threeParams:) perform.

	"tclass renameMethod: symbol to: #renamedBut:stillTakes:threeParams:".
	self deny: (tclass selectors includes: symbol).
	self assert: (tclass selectors includes: #renamedBut:stillTakes:threeParams:).
	self assert: (tclass sourceCodeAt: #renamedBut:stillTakes:threeParams:) = 'renamedBut: firstPar stillTakes: secondPar threeParams: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: (testClass userMethod = 60)! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 21:03'!
test15shouldRenameNonUsedClass
	|renamed|
	
	(ClassRenameRefactor forClass:testClass to: 'RenamedClass') perform.

"	testClass rename: 'RenamedClass'."
	self assert: ((renamed := Smalltalk classNamed: 'RenamedClass') instVarNames = #('varOne')). 
	(ClassRenameRefactor forClass:renamed to: 'TestClass') perform.

"	renamed rename: 'TestClass'"! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 21:06'!
test16RenamingMethodDifferentNumberOfKeywordsShouldThrowException
	testClass class compile: 'thisMethodWill: firstPar throwAnException: secondPar ^firstPar + secondPar'.
	self assert: (testClass class selectors includes: #thisMethodWill:throwAnException:).
	self deny: (testClass class selectors includes: #thisSelectorWontEverExist).
		

	self should: [(MethodRenameRefactor forClass: testClass class on:  #thisMethodWill:throwAnException:  to: #thisSelectorWontEverExist) perform] raise: RefactoringException description: RefactoringException differentKeywordsAmountMessage .
	self assert: (testClass class selectors includes: #thisMethodWill:throwAnException:).
	self deny: (testClass class selectors includes: #thisSelectorWontEverExist).
	self assert: (testClass class sourceCodeAt: #thisMethodWill:throwAnException:) = 'thisMethodWill: firstPar throwAnException: secondPar ^firstPar + secondPar'..
! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 22:19'!
test17RenamingInstanceVariableThatDoesntExistShouldRaiseException
	self assert: (testClass instanceVariablesString = 'varOne').

	self should:[(InstanceVariableRenameRefactor forClass: testClass on: 'renamed' to: 'renamed')perform.] raise: Error description: 'renamed is not defined in the class'.
	self assert: (testClass instanceVariablesString = 'varOne').! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 21:10'!
test18RenamingInstanceVariableToSomethingThatAlreadyExistsShouldRaiseException
	testClass addInstVarName: 'another'.
	self assert: (testClass instanceVariablesString = 'varOne another').
	self should:[(InstanceVariableRenameRefactor  forClass: testClass on: 'varOne' to: 'another')perform.] raise: Error description: 'another is already used in TestClass'.
	self assert: (testClass instanceVariablesString = 'varOne another').
! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/24/2013 00:17'!
test19RenamingClassVariableThatDoesntExistShouldRaiseException
       self assert: (testClass classVariablesString = 'ClassVarOne').
       self should:[(ClassVariableRenameRefactor forClass:testClass on:'NlassVarOne' to:'Renamed')perform.] raise: Error description: 'NlassVarOne is not defined in the class'.
       self assert: (testClass classVariablesString = 'ClassVarOne')

! !

!RefactoringTest methodsFor: 'tests' stamp: 'AA 10/23/2013 21:16'!
test20RenamingClassVariableToSomethingThatAlreadyExistsShouldRaiseException
	testClass addClassVarName: 'Another'.
	self assert: (testClass classVariablesString = 'Another ClassVarOne').
	self should:[(ClassRenameRefactor forClass:'ClassVarOne' to: 'Another')perform.] raise: Error description: 'Another is already used in TestClass'.
	self assert: (testClass classVariablesString = 'Another ClassVarOne').
! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/27/2013 17:16'!
test21shouldUndoRenameUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	testClass compile: 'useInstVar varOne := 3. ^varOne'.
	((InstanceVariableRenameRefactor forClass:testClass on: 'varOne' to: 'renamed') perform)undo.

"	testClass renameSilentlyInstVar: 'varOne' to: 'renamed'."
	self assert: (testClass instanceVariablesString = 'varOne').
	self assert: (testClass new useInstVar = 3).
	self assert: ((testClass sourceCodeAt: #useInstVar) = 'useInstVar varOne := 3. ^varOne')! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/27/2013 17:16'!
test22shouldUndoRenameUsedClassVariable.

	self assert: (testClass classVariablesString = 'ClassVarOne').
	testClass class compile: 'newMethod ClassVarOne := 42. ^ClassVarOne'.
	((ClassVariableRenameRefactor forClass:testClass on: 'ClassVarOne' to: 'Renamed') perform)undo.

	"testClass renameSilentlyClassVar:'ClassVarOne' to: 'Renamed'."
	self assert: (testClass classVariablesString = 'ClassVarOne').
	self assert: (testClass newMethod = 42).
	self assert: (testClass class  sourceCodeAt: #newMethod) = 'newMethod ClassVarOne := 42. ^ClassVarOne'.! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/27/2013 17:44'!
test23shouldUndoRenameUsedInstanceMethod
	| oldMethodName|
	oldMethodName := 'instMetho','dToRename'.
	testClass compile: oldMethodName ,' ^12'.
	testClass compile: 'newMethod ^self iWasRenamed'.
	self assert: (testClass selectors includes: oldMethodName asSymbol).
	self deny: (testClass selectors includes: #iWasRenamed).
	
	((MethodRenameRefactor forClass:testClass on: oldMethodName asSymbol to: #iWasRenamed) perform)undo.

	"testClass renameMethod:  oldMethodName asSymbol to: #iWasRenamed."
	self deny: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass selectors includes: oldMethodName asSymbol).
	self assert: ((testClass sourceCodeAt: oldMethodName asSymbol) = (oldMethodName ,' ^12')).! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/27/2013 17:44'!
test24shouldUndoRenameUsedClassInstanceVariable
	self assert: (testClass class instanceVariablesString = 'cinvar').
	testClass class compile: 'useCIV cinvar := 23. ^cinvar'.
	((InstanceVariableRenameRefactor forClass:testClass class on: 'cinvar'  to: 'cvrenamed') perform)undo.

"	testClass class renameSilentlyInstVar: 'cinvar' to: 'cvrenamed'."
	self assert: (testClass class instanceVariablesString = 'cinvar').
	self assert: (testClass useCIV = 23).
	self assert: ((testClass class sourceCodeAt: #useCIV) =   'useCIV cinvar := 23. ^cinvar').! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/27/2013 17:46'!
test25shouldUndoRenameUsedClassMethod
	|tclass oldMethodName|
	tclass := testClass class .
	oldMethodName := 'classMethodToUse'.
	testClass class compile: oldMethodName , ' ^9'.
	tclass compile: 'methodThatUsed ^self ',oldMethodName .
	self assert: (tclass selectors includes: oldMethodName asSymbol ).
	self deny: (tclass selectors includes: #afterRenaming).
	((MethodRenameRefactor forClass: tclass on: oldMethodName asSymbol  to: #afterRenaming) perform)undo.

"	tclass renameMethod: oldMethodName asSymbol to: #afterRenaming."
	self deny: (tclass selectors includes: #afterRenaming).
	self assert: (tclass selectors includes: oldMethodName asSymbol).
	self assert: ((tclass sourceCodeAt: oldMethodName asSymbol) = (oldMethodName , ' ^9')).! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/27/2013 18:57'!
test26undoRenameUsedInstanceVariableShoulBeInOrganizer.
	self assert: (testClass instanceVariablesString = 'varOne').
	testClass compile: 'useInstVar varOne := 3. ^varOne'.
	(InstanceVariableRenameRefactor forClass:testClass on: 'varOne' to: 'renamed') perform.

	self assert: (RefactorOrganizer instance refactors size =1).
	self assert: (((RefactorOrganizer instance refactors at:1) newName)=  'renamed') .! !

!RefactoringTest methodsFor: 'tests' stamp: 'Aa 10/27/2013 19:19'!
test27refactorOrganizerCanUndoAndRedo
	|instance|
	instance:=RefactorOrganizer instance.
	self assert: (testClass instanceVariablesString = 'varOne').
	testClass compile: 'useInstVar varOne := 3. ^varOne'.
	(InstanceVariableRenameRefactor forClass:testClass on: 'varOne' to: 'renamed') perform.
	instance undo: (instance refactors at:1).
	self assert: ( instance refactors size =0).
	instance redo.
	self assert: ( instance refactors size =1).
	self assert: ((( instance refactors at:1) newName)=  'renamed') .! !

!RefactoringTest class methodsFor: 'as yet unclassified' stamp: 'NR 9/29/2013 23:37'!
runSuite
	(RefactoringTest selectors select:	
		[:sel | (sel asString first: 4) = 'test']) 
			do:
			 [:method | self new setUp perform: method;tearDown].! !

!Usage methodsFor: 'as yet unclassified' stamp: 'AA 10/15/2013 20:39'!
classRef
	^methodRef classIsMeta ifTrue:[(Smalltalk classNamed: methodRef classSymbol asString) class] ifFalse:[Smalltalk classNamed: methodRef classSymbol asString].! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/15/2013 00:17'!
initializeWith: methodReference replace: original with: replacement
	methodRef := methodReference.
	oldCode := self classRef sourceCodeAt: methodRef methodSymbol.
	newCode := oldCode copyReplaceTokens: original  with: replacement
! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 01:10'!
initializeWith: methodReference replaceCollection: originals with: replacements
	methodRef := methodReference.
	oldCode := self classRef sourceCodeAt: methodRef methodSymbol.
	newCode := oldCode.
	
	1 to: originals size do:[:i | 	
			newCode := newCode copyReplaceTokens: (originals at: i)  with: (replacements at: i).
			].! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 21:04'!
methodSymbol.
	^ methodRef methodSymbol.! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 22:49'!
newCode
	^newCode! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/23/2013 22:49'!
oldCode
	^oldCode! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/18/2013 01:39'!
perform
	| class|
	class := self classRef.
	class removeSelector: methodRef methodSymbol.
	class compile: newCode.! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/18/2013 01:40'!
undo
	| class|
	class := self classRef.
	class removeSelector: methodRef methodSymbol.
	class compile: oldCode.! !

!Usage class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:18'!
on: methodRef replace: original with: replacement
	^self new initializeWith: methodRef replace: original with: replacement.! !

!Usage class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:18'!
on: methodRef replaceCollection: originals with: replacements
	^self new initializeWith: methodRef replaceCollection: originals with: replacements.! !
