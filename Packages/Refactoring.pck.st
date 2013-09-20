'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 19 September 2013 at 9:31:31.987 pm'!
'Description '!
!provides: 'Refactoring' 1 2!
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


!Refactor class methodsFor: 'methods' stamp: 'NR 9/19/2013 21:16'!
refactor: class renameClassVariable: name to: newName
	class renameSilentlyClassVar: name to: newName.! !

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

!RefactoringTest class methodsFor: 'as yet unclassified' stamp: 'NR 9/19/2013 21:30'!
runSuite
	||
	(RefactoringTest selectors select:	
		[:sel | (sel asString first: 4) = 'test']) 
			do:
			 [:method | self new setUp perform: method;tearDown]! !
