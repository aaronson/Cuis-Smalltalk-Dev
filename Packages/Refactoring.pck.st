'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 23 September 2013 at 7:15:22.228 pm'!
'Description '!
!provides: 'Refactoring' 1 5!
!classDefinition: #Refactor category: #Refactoring!
Object subclass: #Refactor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'Refactor class' category: #Refactoring!
Refactor class
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

!classDefinition: #Testing category: #Refactoring!
Object subclass: #Testing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!
!classDefinition: 'Testing class' category: #Refactoring!
Testing class
	instanceVariableNames: ''!


!Refactor class methodsFor: 'methods' stamp: 'NR 9/19/2013 21:16'!
refactor: class renameClassVariable: name to: newName
	class renameSilentlyClassVar: name to: newName.! !

!Refactor class methodsFor: 'methods' stamp: 'NR 9/21/2013 20:46'!
refactor: class renameInstanceMethod: oldSelector to: newSelector
	|usages code selwordsOld selwordsNew arguments header newHeader colon| 
	newHeader := ''.
	selwordsOld := oldSelector asString findTokens: ':'.
	selwordsNew := newSelector asString findTokens: ':'.
	arguments := (Parser new parse: ( header := class methodHeaderFor: oldSelector) class: class) arguments collect: [:each | each name].

	(selwordsOld size = selwordsNew size) ifFalse: [Exception new signal: 'The new name should contain the same amount of keywords as the old'].
	
	usages := Smalltalk allCallsOn: oldSelector.
	code := class sourceCodeAt: oldSelector.
	arguments isEmpty 
		ifTrue: [ colon := ''. 
			newHeader := newSelector asString.] 
		ifFalse: [ colon := ':'.
			 arguments with: selwordsNew do: [:arg :sel | newHeader := newHeader, sel asString,': ',arg,' ']].
	code := newHeader, (code allButFirst: (header size)).
	
	class removeSelector: oldSelector.
	class compile: code.
	"TODO: dont replace over all the class, just over the actual method"
	usages do:[:ref |
		1 to: selwordsOld size do:[:i | 	
			ref actualClass replaceSilently: ((selwordsOld at: i),colon) to: ((selwordsNew at: i),colon) 
			]
		].
	
	
! !

!Refactor class methodsFor: 'methods' stamp: 'NR 9/15/2013 01:41'!
refactor: class renameInstanceVariable: name to: newName
	class renameSilentlyInstVar: name to: newName.! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 00:47'!
setUp
	super setUp.
	testClass := Object subclass: #TestClass instanceVariableNames: 'varOne' classVariableNames: 'ClassVarOne'  poolDictionaries: '' category: 'Refactoring'.
	! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 21:31'!
tearDown
	testClass removeFromSystem! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/15/2013 00:53'!
test1shouldRenameNonUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	Refactor refactor: testClass renameInstanceVariable: 'varOne' to: 'renamed'.
	self assert: (testClass instanceVariablesString = 'renamed').! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 20:16'!
test2shouldRenameNonUsedClassVariable.
	self assert: (testClass classVariablesString = 'ClassVarOne').
	Refactor refactor: testClass renameClassVariable:'ClassVarOne' to: 'Renamed'.
	self assert: (testClass classVariablesString = 'Renamed').! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 00:56'!
test3shouldRenameUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	testClass compile: 'useInstVar varOne := 3. ^varOne'.
	Refactor refactor: testClass renameInstanceVariable: 'varOne' to: 'renamed'.
	self assert: (testClass instanceVariablesString = 'renamed').
	self assert: (testClass new useInstVar = 3).
	self assert: ((testClass sourceCodeAt: #useInstVar) = 'useInstVar renamed := 3. ^renamed')! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 21:30'!
test4shouldRenameUsedClassVariable.
	self assert: (testClass classVariablesString = 'ClassVarOne').
	Refactor refactor: testClass renameClassVariable:'ClassVarOne' to: 'Renamed'.
	testClass class compile: 'newMethod ClassVarOne := 42. ^ClassVarOne'.
	self assert: (testClass classVariablesString = 'Renamed').
	self assert: (testClass newMethod = 42).
	self assert: (testClass class  sourceCodeAt: #newMethod) = 'newMethod ClassVarOne := 42. ^ClassVarOne'.! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/23/2013 19:14'!
test5shouldRenameNonUsedInstanceMethod
	testClass compile: 'methodToRename ^12'.
	self assert: (testClass selectors includes: #methodToRename).
	self deny: (testClass selectors includes: #iWasRenamed).
	Refactor refactor: testClass renameInstanceMethod: #methodToRename to: #iWasRenamed.
	self deny: (testClass selectors includes: #methodToRename).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/23/2013 19:14'!
test6shouldRenameNonUsedInstanceMethodWithMultipleKeywords
	testClass compile: 'thisIsAMethod: firstPar thatUses: secondPar multipleKeywords: thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass selectors includes: #thisIsAMethod:thatUses:multipleKeywords:).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	Refactor refactor: testClass renameInstanceMethod: #thisIsAMethod:thatUses:multipleKeywords: to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: #thisIsAMethod:thatUses:keywordNames:).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).! !

!RefactoringTest class methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 21:30'!
runSuite
	||
	(RefactoringTest selectors select:	
		[:sel | (sel asString first: 4) = 'test']) 
			do:
			 [:method | self new setUp perform: method;tearDown]! !

!Testing methodsFor: 'as yet unclassified' stamp: 'NR 9/21/2013 19:35'!
aMessage
	^1.! !

!Testing methodsFor: 'as yet unclassified' stamp: 'NR 9/21/2013 20:38'!
cuatro: a cinco: b seis: c  
	| eee eed |
	eee := 1.
	eed := 2.
	^eee+eed. ! !

!Testing methodsFor: 'as yet unclassified' stamp: 'NR 9/21/2013 20:38'!
usame
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.

	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
	self cuatro: 'u' cinco: 'befe' seis: 'ooe'.
! !
