'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 15 October 2013 at 8:41:03.476 pm'!
'Description '!
!provides: 'Refactoring' 1 13!
!classDefinition: #RefactoringException category: #Refactoring!
Error subclass: #RefactoringException
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'RefactoringException class' category: #Refactoring!
RefactoringException class
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

!classDefinition: #DummyRefactor category: #Refactoring!
Refactor subclass: #DummyRefactor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'DummyRefactor class' category: #Refactoring!
DummyRefactor class
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
	instanceVariableNames: 'class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'MethodRenameRefactor class' category: #Refactoring!
MethodRenameRefactor class
	instanceVariableNames: ''!

!classDefinition: #RefactorOrganizer category: #Refactoring!
Object subclass: #RefactorOrganizer
	instanceVariableNames: 'refactors lastUndoneRefactor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'RefactorOrganizer class' category: #Refactoring!
RefactorOrganizer class
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


!RefactoringException class methodsFor: 'as yet unclassified' stamp: 'NR 9/30/2013 00:17'!
differentKeywordsAmountMessage
	^'The new name should contain the same amount of keywords as the old method name'! !

!Refactor methodsFor: 'as yet unclassified' stamp: 'NR 10/9/2013 20:46'!
perform
	self subclassResponsibility ! !

!Refactor methodsFor: 'as yet unclassified' stamp: 'NR 10/9/2013 20:49'!
undo! !

!ClassRenameRefactor methodsFor: 'as yet unclassified' stamp: 'AA 10/15/2013 20:35'!
initializeForClass: aClassName to: aNewClassName

	oldName := aClassName.
	newName := aNewClassName .
	usages := OrderedCollection new.

	(Smalltalk allCallsOn: (Smalltalk associationAt: oldName))
		do:[ :usg | 
			usages add: (Usage on: usg replace: oldName with: newName)
			].! !

!ClassRenameRefactor methodsFor: 'as yet unclassified' stamp: 'AA 10/15/2013 20:32'!
perform
	(Smalltalk classNamed: oldName) rename: newName.
	usages do: [:usg | usg perform].! !

!ClassRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:00'!
forClass: aClassName to: aNewName
	^self new initializeForClass: aClassName to: aNewName! !

!ClassVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/14/2013 20:01'!
initializeForClass: aClass on: anOldMethodName to: aNewMethodName
	|meta|
	class := aClass.
	oldName := anOldMethodName.
	newName := aNewMethodName.
	meta:= class class.
	usages := OrderedCollection new.

	meta withAllSubclasses do: [ :cls | |  sels |
		sels _ cls selectors.
		sels do: [ :sel | ((meta sourceCodeAt: sel) includesSubString: oldName) ifTrue:[
				usages add: (Usage on: (MethodReference class: meta selector: sel) replace: oldName with: newName)
				]
			]
		].! !

!ClassVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/15/2013 00:19'!
perform
 	"TODO check for exceptions" 
	class addClassVarName: newName.
	class replaceClassVarName: oldName to: newName.
	usages do: [:usg | usg perform].
	class removeClassVarName: oldName.! !

!ClassVariableRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:01'!
forClass: aClassName on: anOldVarName to: aNewVarName
	^self new initializeForClass: aClassName on: anOldVarName to: aNewVarName! !

!InstanceVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:34'!
initializeForClass: aClass on: anOldMethodName to: aNewMethodName
	
	class := aClass.
	oldName := anOldMethodName.
	newName := aNewMethodName.
	
	usages := OrderedCollection new.
	"Find how many keywords are there"
	class withAllSubclasses do: [ :cls | |  sels |
		sels _ cls selectors.
		sels do: [ :sel | ((class sourceCodeAt: sel) includesSubString: oldName) ifTrue:[
				usages add: (Usage on: (MethodReference class: class selector: sel) replace: oldName with: newName)
				]
			]
		].
 
! !

!InstanceVariableRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:39'!
perform
	class replaceInstVarName: oldName to: newName.
	usages do: [:usg | usg perform]! !

!InstanceVariableRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:00'!
forClass: aClassName on: anOldVarName to: aNewVarName
	^self new initializeForClass: aClassName on: anOldVarName to: aNewVarName! !

!MethodRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:32'!
initializeForClass: aClass on: anOldMethodName to: aNewMethodName
	| selwordsOld selwordsNew| 
	class := aClass.
	oldName := anOldMethodName.
	newName := aNewMethodName.
	
	"Find how many keywords are there"
	selwordsOld := oldName asString findTokens: ':'.
	selwordsNew := newName asString findTokens: ':'.
	(selwordsOld size = selwordsNew size) ifFalse: [RefactoringException new signal: RefactoringException differentKeywordsAmountMessage ].	
	
	usages := (Smalltalk allCallsOn: anOldMethodName asSymbol) collect: [:usg | Usage on: usg replaceCollection: selwordsOld with: selwordsNew].! !

!MethodRenameRefactor methodsFor: 'as yet unclassified' stamp: 'NR 10/11/2013 00:35'!
perform
	| code selwordsNew arguments header newHeader | 
	
	newHeader := ''.
	selwordsNew := newName asString findTokens: ':'.

	"Obtain the arguments names to use them when replacing the code"
	arguments := (Parser new parse: ( header := class methodHeaderFor: oldName) class: class) arguments collect: [:each | each name].
	
	code := class sourceCodeAt: oldName.
	
	"Build the new message header"
	arguments isEmpty 
		ifTrue: [ newHeader := newName asString.]
		ifFalse: [ arguments with: selwordsNew do: [:arg :sel | newHeader := newHeader, sel asString,': ',arg,' ']].
		
	"Build the new message text"
	code := newHeader, (code allButFirst: (header size)).
	
	class removeSelector: oldName.
	class compile: code.
	
	"Replace the old method name in each of the usages with the new name"
	usages do:[:usg | usg perform.]! !

!MethodRenameRefactor class methodsFor: 'as yet unclassified' stamp: 'NR 10/10/2013 23:20'!
forClass: aClassName on: anOldMethodName to: aNewMethodName
	^self new initializeForClass: aClassName on: anOldMethodName to: aNewMethodName! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/9/2013 20:53'!
initialize
	refactors := OrderedCollection new.
	lastUndoneRefactor := DummyRefactor new.! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/9/2013 21:10'!
redo
	"ver que no sea dummy"
	lastUndoneRefactor perform.
	refactors addFirst: lastUndoneRefactor.
	lastUndoneRefactor := DummyRefactor new.! !

!RefactorOrganizer methodsFor: 'as yet unclassified' stamp: 'NR 10/9/2013 21:06'!
undo: aRefactor

	(refactors includes: aRefactor) ifFalse: [RefactoringException new signal: 'Unrecognized refactor'].
	aRefactor undo.
	lastUndoneRefactor := aRefactor.
	1 to: (refactors indexOf: aRefactor) do: [refactors removeFirst.].! !

!RefactoringTest methodsFor: 'Running' stamp: 'NR 9/24/2013 21:05'!
setUp
	super setUp.
	testClass := Object subclass: #TestClass instanceVariableNames: 'varOne' classVariableNames: 'ClassVarOne'  poolDictionaries: '' category: 'Refactoring'.
	testClass class addInstVarName: 'cinvar'
	! !

!RefactoringTest methodsFor: 'Running' stamp: 'NR 9/19/2013 21:31'!
tearDown
	testClass removeFromSystem! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:53'!
test01shouldRenameNonUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	testClass renameSilentlyInstVar: 'varOne' to: 'renamed'.
	self assert: (testClass instanceVariablesString = 'renamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:53'!
test02shouldRenameNonUsedClassVariable.
	self assert: (testClass classVariablesString = 'ClassVarOne').
	testClass renameSilentlyClassVar: 'ClassVarOne' to: 'Renamed'.
	self assert: (testClass classVariablesString = 'Renamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:53'!
test03shouldRenameUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	testClass compile: 'useInstVar varOne := 3. ^varOne'.
	testClass renameSilentlyInstVar: 'varOne' to: 'renamed'.
	self assert: (testClass instanceVariablesString = 'renamed').
	self assert: (testClass new useInstVar = 3).
	self assert: ((testClass sourceCodeAt: #useInstVar) = 'useInstVar renamed := 3. ^renamed')! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:53'!
test04shouldRenameUsedClassVariable.

	self assert: (testClass classVariablesString = 'ClassVarOne').
	testClass class compile: 'newMethod ClassVarOne := 42. ^ClassVarOne'.
	testClass renameSilentlyClassVar:'ClassVarOne' to: 'Renamed'.
	self assert: (testClass classVariablesString = 'Renamed').
	self assert: (testClass newMethod = 42).
	self assert: (testClass class  sourceCodeAt: #newMethod) = 'newMethod Renamed := 42. ^Renamed'.! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 19:30'!
test05shouldRenameNonUsedInstanceMethod
	| oldMethodName|
	oldMethodName := 'methodT','oRename'.
 
	testClass compile: (oldMethodName,' ^12').
	self assert: (testClass selectors includes: oldMethodName asSymbol).
	self deny: (testClass selectors includes: #iWasRenamed).
	testClass renameMethod: oldMethodName asSymbol to: #iWasRenamed.
	self deny: (testClass selectors includes: oldMethodName asSymbol).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 22:21'!
test06shouldRenameNonUsedInstanceMethodWithMultipleKeywords
	| kw1 kw2 kw3 symbol|
	kw1 := 'thisI','sAMethod:'.
	kw2 := 'tha','tUses:'.
	kw3 := 'multip','leParameters:'.
	symbol := (kw1,kw2,kw3) asSymbol.
	testClass compile: kw1,' firstPar ',kw2,' secondPar ',kw3,' thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass selectors includes: symbol).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	testClass renameMethod: symbol to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: symbol).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).
! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 22:32'!
test07shouldRenameUsedInstanceMethod
	| oldMethodName|
	oldMethodName := 'instMetho','dToRename'.
	testClass compile: oldMethodName ,' ^12'.
	testClass compile: 'newMethod ^self methodToRename'.
	self assert: (testClass selectors includes: oldMethodName asSymbol).
	self deny: (testClass selectors includes: #iWasRenamed).
	testClass renameMethod:  oldMethodName asSymbol to: #iWasRenamed.
	self deny: (testClass selectors includes: oldMethodName asSymbol).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 22:49'!
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
	testClass renameMethod: symbol to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: symbol).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:54'!
test09shouldRenameNonUsedClassInstanceVariable
	self assert: (testClass class instanceVariablesString = 'cinvar').
	testClass class renameSilentlyInstVar: 'cinvar' to: 'cvrenamed'.
	self assert: (testClass class instanceVariablesString = 'cvrenamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/29/2013 23:34'!
test10shouldRenameUsedClassInstanceVariable
	self assert: (testClass class instanceVariablesString = 'cinvar').
	testClass class compile: 'useCIV cinvar := 23. ^cinvar'.
	testClass class renameSilentlyInstVar: 'cinvar' to: 'cvrenamed'.
	self assert: (testClass class instanceVariablesString = 'cvrenamed').
	self assert: (testClass useCIV = 23).
	self assert: ((testClass class sourceCodeAt: #useCIV) =   'useCIV cvrenamed := 23. ^cvrenamed').! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 22:43'!
test11shouldRenameNonUsedClassMethod
	| oldMethodName|
	oldMethodName := 'classMetho','dToRename'.
	testClass class compile: oldMethodName ,' ^2+3'.
	self assert: (testClass class selectors includes: oldMethodName asSymbol ).
	self deny: (testClass class selectors includes: #methodRenamed).
	testClass class renameMethod: oldMethodName asSymbol to: #methodRenamed.
	self deny: (testClass class selectors includes: oldMethodName asSymbol ).
	self assert: (testClass class selectors includes: #methodRenamed).
	self assert: (testClass class sourceCodeAt: #methodRenamed) = 'methodRenamed ^2+3'.
	self assert: (testClass methodRenamed = 5).! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 22:47'!
test12shouldRenameNonUsedClassMethodWithMultipleKeywords
	| kw1 kw2 kw3 symbol|
	kw1 := 'thisIsACla','ssMethod:'.
	kw2 := 'thatI','sUsing:'.
	kw3 := 'manyPar','ameters:'.
	symbol := (kw1,kw2,kw3) asSymbol.
	testClass class compile: kw1, ' firstPar ',kw2, ' secondPar ',kw3,' thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass class selectors includes: symbol).
	self deny: (testClass class selectors includes: #theClassMethod:hasBeen:renamedAllKeywords:).
	testClass class renameMethod: symbol to: #theClassMethod:hasBeen:renamedAllKeywords:.
	self deny: (testClass class selectors includes: symbol).
	self assert: (testClass class selectors includes: #theClassMethod:hasBeen:renamedAllKeywords:).
	self assert: (testClass class sourceCodeAt: #theClassMethod:hasBeen:renamedAllKeywords:) = 'theClassMethod: firstPar hasBeen: secondPar renamedAllKeywords: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass theClassMethod: 3 hasBeen: 4 renamedAllKeywords: 5) = 12).! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 22:45'!
test13shouldRenameUsedClassMethod
	|tclass oldMethodName|
	tclass := testClass class .
	oldMethodName := 'classMetho','dToUse'.
	testClass class compile: oldMethodName , ' ^9'.
	tclass compile: 'methodThatUsed ^self ',oldMethodName .
	self assert: (tclass selectors includes: oldMethodName asSymbol ).
	self deny: (tclass selectors includes: #afterRenaming).
	tclass renameMethod: oldMethodName asSymbol to: #afterRenaming.
	self deny: (tclass selectors includes: oldMethodName asSymbol).
	self assert: (tclass selectors includes: #afterRenaming).
	self assert: (tclass sourceCodeAt: #afterRenaming) = 'afterRenaming ^9'.
	self assert: (testClass afterRenaming = 9).! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 10/8/2013 23:57'!
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
	tclass renameMethod: symbol to: #renamedBut:stillTakes:threeParams:.
	self deny: (tclass selectors includes: symbol).
	self assert: (tclass selectors includes: #renamedBut:stillTakes:threeParams:).
	self assert: (tclass sourceCodeAt: #renamedBut:stillTakes:threeParams:) = 'renamedBut: firstPar stillTakes: secondPar threeParams: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: (testClass userMethod = 60)! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/29/2013 18:02'!
test15shouldRenameNonUsedClass
	|renamed|
	testClass rename: 'RenamedClass'.
	self assert: ((renamed := Smalltalk classNamed: 'RenamedClass') instVarNames = #('varOne')). 
	renamed rename: 'TestClass'! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:37'!
test16RenamingMethodDifferentNumberOfKeywordsShouldThrowException
	testClass class compile: 'thisMethodWill: firstPar throwAnException: secondPar ^firstPar + secondPar'.
	self assert: (testClass class selectors includes: #thisMethodWill:throwAnException:).
	self deny: (testClass class selectors includes: #thisSelectorWontEverExist).
	self should: [testClass class renameMethod: #thisMethodWill:throwAnException: to: #thisSelectorWontEverExist] raise: RefactoringException description: RefactoringException differentKeywordsAmountMessage .
	self assert: (testClass class selectors includes: #thisMethodWill:throwAnException:).
	self deny: (testClass class selectors includes: #thisSelectorWontEverExist).
	self assert: (testClass class sourceCodeAt: #thisMethodWill:throwAnException:) = 'thisMethodWill: firstPar throwAnException: secondPar ^firstPar + secondPar'..
! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:49'!
test17RenamingInstanceVariableThatDoesntExistShouldRaiseException
	self assert: (testClass instanceVariablesString = 'varOne').
	self should:[testClass renameSilentlyInstVar: 'notexist' to: 'renamed'.] raise: Error description: 'notexist is not defined in TestClass'.
	self assert: (testClass instanceVariablesString = 'varOne').! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:51'!
test18RenamingInstanceVariableToSomethingThatAlreadyExistsShouldRaiseException
	testClass addInstVarName: 'another'.
	self assert: (testClass instanceVariablesString = 'varOne another').
	self should:[testClass renameSilentlyInstVar: 'varOne' to: 'another'.] raise: Error description: 'another is already used in TestClass'.
	self assert: (testClass instanceVariablesString = 'varOne another').
! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:55'!
test19RenamingClassVariableThatDoesntExistShouldRaiseException
	self assert: (testClass classVariablesString = 'ClassVarOne').
	self should:[testClass renameSilentlyClassVar: 'NlassVarOne' to: 'Renamed'.] raise: Error description: 'Notexist is not defined in TestClass'.
	self assert: (testClass classVariablesString = 'ClassVarOne').! !

!RefactoringTest methodsFor: 'tests' stamp: 'NR 9/30/2013 00:52'!
test20RenamingClassVariableToSomethingThatAlreadyExistsShouldRaiseException
	testClass addClassVarName: 'Another'.
	self assert: (testClass classVariablesString = 'Another ClassVarOne').
	self should:[testClass renameSilentlyClassVar: 'ClassVarOne' to: 'Another'.] raise: Error description: 'Another is already used in TestClass'.
	self assert: (testClass classVariablesString = 'Another ClassVarOne').
! !

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

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:18'!
initializeWith: methodReference replaceCollection: originals with: replacements
	methodRef := methodReference.
	oldCode := (Smalltalk classNamed: methodRef classSymbol asString) sourceCodeAt: methodRef methodSymbol.
	newCode := oldCode.
	
	1 to: originals size do:[:i | 	
			newCode := newCode copyReplaceTokens: (originals at: i)  with: (replacements at: i).
			].! !

!Usage methodsFor: 'as yet unclassified' stamp: 'NR 10/15/2013 00:18'!
perform
	| class|
	class := self classRef.
	class removeSelector: methodRef methodSymbol.
	class compile: newCode.! !

!Usage class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:18'!
on: methodRef replace: original with: replacement
	^self new initializeWith: methodRef replace: original with: replacement.! !

!Usage class methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2013 21:18'!
on: methodRef replaceCollection: originals with: replacements
	^self new initializeWith: methodRef replaceCollection: originals with: replacements.! !
