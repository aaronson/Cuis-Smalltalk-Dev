!classDefinition: #Refactor category: #Refactoring!
Object subclass: #Refactor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Refactor class' category: #Refactoring!
Refactor class
	instanceVariableNames: ''!

!Refactor class methodsFor: 'as yet unclassified' stamp: 'NR 9/15/2013 01:41'!
refactor: class renameInstanceVariable: name to: newName
	class renameSilentlyInstVar: name to: newName.! !


!classDefinition: #RefactoringTest category: #Refactoring!
TestCase subclass: #RefactoringTest
	instanceVariableNames: 'testClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Refactoring'!

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/15/2013 01:27'!
setUp
	super setUp.
	testClass := Object subclass: #TestClass instanceVariableNames: 'varOne' classVariableNames: 'ClassVarOne'  poolDictionaries: '' category: 'Refactoring'.
	! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/15/2013 01:45'!
tearDown
	testClass removeFromSystem! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/15/2013 00:53'!
test1shouldRenameNonUsedInstanceVariable.
	self assert: (testClass instanceVariablesString = 'varOne').
	Refactor refactor: testClass renameInstanceVariable: 'varOne' to: 'renamed'.
	self assert: (testClass instanceVariablesString = 'renamed').! !

!RefactoringTest methodsFor: 'as yet unclassified' stamp: 'NR 9/17/2013 00:02'!
test2shouldRenameNonUsedInstanceVariable.
	self assert: (testClass classVariablesString = 'ClassVarOne').
	Refactor refactor: testClass renameClassVariable: 'ClassVarOne' to: 'Renamed'.
	self assert: (testClass classVariablesString = 'Renamed').! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RefactoringTest class' category: #Refactoring!
RefactoringTest class
	instanceVariableNames: ''!

!RefactoringTest class methodsFor: 'as yet unclassified' stamp: 'NR 9/17/2013 00:01'!
runSuite
	|temp|
	(RefactoringTest selectors select:	
		[:sel | (sel asString first: 4) = 'test']) 
			do:
			 [:method | temp := self new setUp. 
				[temp perform: method] ensure: temp tearDown]! !
