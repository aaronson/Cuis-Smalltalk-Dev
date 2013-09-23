test6shouldRenameNonUsedInstanceMethodWithMultipleKeywords
	testClass compile: 'thisIsAMethod: firstPar thatUses: secondPar multipleKeywords: thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass selectors includes: #thisIsAMethod:thatUses:multipleKeywords:).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	Refactor refactor: testClass renameInstanceMethod: #thisIsAMethod:thatUses:multipleKeywords: to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: #thisIsAMethod:thatUses:keywordNames:).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).


test5shouldRenameNonUsedInstanceMethod
	testClass compile: 'methodToRename ^12'.
	self assert: (testClass selectors includes: #methodToRename).
	self deny: (testClass selectors includes: #iWasRenamed).
	Refactor refactor: testClass renameInstanceMethod: #methodToRename to: #iWasRenamed.
	self deny: (testClass selectors includes: #methodToRename).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).
