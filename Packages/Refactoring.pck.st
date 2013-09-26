'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 25 September 2013 at 9:06:34.978 pm'!
'Description '!
!provides: 'Refactoring' 1 7!
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
	instanceVariableNames: 'renamed'!


!Refactor class methodsFor: 'methods' stamp: 'NR 9/24/2013 21:01'!
refactor: aClass renameClassInstanceVariable: name to: newName
	aClass class renameSilentlyInstVar: name to: newName.! !

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

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/24/2013 21:05'!
setUp
	super setUp.
	testClass := Object subclass: #TestClass instanceVariableNames: 'varOne' classVariableNames: 'ClassVarOne'  poolDictionaries: '' category: 'Refactoring'.
	testClass class addInstVarName: 'cinvar'
	! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 21:31'!
tearDown
	testClass removeFromSystem! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/24/2013 23:47'!
test10shouldRenameUsedClassInstanceVariable
	self assert: (testClass class instanceVariablesString = 'cinvar').
	testClass class compile: 'useCIV cinvar := 23. ^cinvar'.
	Refactor refactor: testClass renameClassInstanceVariable: 'cinvar' to: 'cvrenamed'.
	self assert: (testClass class instanceVariablesString = 'cvrenamed').
	self assert: (testClass useCIV = 23).
	self assert: ((testClass class sourceCodeAt: #useCIV) =   'useCIV cvrenamed := 23. ^cvrenamed').! !

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

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/25/2013 01:33'!
test4shouldRenameUsedClassVariable.
	self assert: (testClass classVariablesString = 'ClassVarOne').
	testClass class compile: 'newMethod ClassVarOne := 42. ^ClassVarOne'.
	Refactor refactor: testClass renameClassVariable:'ClassVarOne' to: 'Renamed'.
	self assert: (testClass classVariablesString = 'Renamed').
	self assert: (testClass newMethod = 42).
	self assert: (testClass class  sourceCodeAt: #newMethod) = 'newMethod Renamed := 42. ^Renamed'.! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/24/2013 20:52'!
test5shouldRenameNonUsedInstanceMethod
	"testClass compile: 'methodToRename ^12'.
	self assert: (testClass selectors includes: #methodToRename).
	self deny: (testClass selectors includes: #iWasRenamed).
	Refactor refactor: testClass renameInstanceMethod: #methodToRename to: #iWasRenamed.
	self deny: (testClass selectors includes: #methodToRename).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).
"! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'AA 9/25/2013 19:00'!
test6shouldRenameNonUsedInstanceMethodWithMultipleKeywords
	"testClass compile: 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass selectors includes: #thisIsAMethod:thatUses:keywordNames:).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	Refactor refactor: testClass renameInstanceMethod: #thisIsAMethod:thatUses:keywordNames: to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: #thisIsAMethod:thatUses:keywordNames:).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42)."! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'AA 9/25/2013 19:05'!
test7shouldRenameUsedInstanceMethod
"	testClass compile: 'methodToRename ^12'.
	testClass compile: 'newMethod ^self methodToRename'.
	self assert: (testClass selectors includes: #methodToRename).
	self deny: (testClass selectors includes: #iWasRenamed).
	Refactor refactor: testClass renameInstanceMethod: #methodToRename to: #iWasRenamed.
	self deny: (testClass selectors includes: #methodToRename).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12)."! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'AA 9/25/2013 19:05'!
test8shouldRenameUsedInstanceMethodWithMultipleKeywords
"	testClass compile: 'thisIsAMethod: firstPar thatUses: secondPar multipleParameters: thirdPar ^firstPar + secondPar + thirdPar'.
	testClass compile: 'newMethod ^self thisIsAMethod:1 thatUses:2 multipleParameters:3'.
	self assert: (testClass selectors includes: #thisIsAMethod:thatUses:multipleParameters:).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	Refactor refactor: testClass renameInstanceMethod: #thisIsAMethod:thatUses:multipleParameters: to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: #thisIsAMethod:thatUses:multipleParameters:).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42)."! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/24/2013 22:52'!
test9shouldRenameNonUsedClassInstanceVariable
	self assert: (testClass class instanceVariablesString = 'cinvar').
	Refactor refactor: testClass renameClassInstanceVariable: 'cinvar' to: 'cvrenamed'.
	self assert: (testClass class instanceVariablesString = 'cvrenamed').! !

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

!Testing methodsFor: 'as yet unclassified' stamp: 'NR 9/24/2013 21:19'!
otro
	self class ! !

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

!Testing class methodsFor: 'as yet unclassified' stamp: 'NR 9/24/2013 23:28'!
hola ^2! !

!Testing class methodsFor: 'as yet unclassified' stamp: 'NR 9/24/2013 22:37'!
soyUnMsj
	renamed := 2.! !
