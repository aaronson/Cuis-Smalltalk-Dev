test05shouldRenameNonUsedInstanceMethod
	testClass compile: 'methodToRename ^12'.
	self assert: (testClass selectors includes: #methodToRename).
	self deny: (testClass selectors includes: #iWasRenamed).
	testClass renameMethod: #methodToRename to: #iWasRenamed.
	self deny: (testClass selectors includes: #methodToRename).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).

test06shouldRenameNonUsedInstanceMethodWithMultipleKeywords
	testClass compile: 'thisIsAMethod: firstPar thatUses: secondPar multipleParameters: thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass selectors includes: #thisIsAMethod:thatUses:multipleParameters:).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	testClass renameMethod: #thisIsAMethod:thatUses:multipleParameters: to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: #thisIsAMethod:thatUses:multipleParameters:).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).

test07shouldRenameUsedInstanceMethod
	testClass compile: 'instMethodToRename ^12'.
	testClass compile: 'newMethod ^self methodToRename'.
	self assert: (testClass selectors includes: #instMethodToRename).
	self deny: (testClass selectors includes: #iWasRenamed).
	testClass renameMethod: #instMethodToRename to: #iWasRenamed.
	self deny: (testClass selectors includes: #instMethodToRename).
	self assert: (testClass selectors includes: #iWasRenamed).
	self assert: (testClass sourceCodeAt: #iWasRenamed) = 'iWasRenamed ^12'.
	self assert: (testClass new iWasRenamed = 12).

test08shouldRenameUsedInstanceMethodWithMultipleKeywords
	testClass compile: 'thisUsedMethod: firstPar isTaking: secondPar threeDiffParams: thirdPar ^firstPar + secondPar + thirdPar'.
	testClass compile: 'newMethod ^self thisUsedMethod:1 isTaking:2 threeDiffParams:3'.
	self assert: (testClass selectors includes: #thisUsedMethod:isTaking:threeDiffParams:).
	self deny: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	testClass renameMethod: #thisUsedMethod:isTaking:threeDiffParams: to: #andNow:hasNew:keywordNames:.
	self deny: (testClass selectors includes: #thisUsedMethod:isTaking:threeDiffParams:).
	self assert: (testClass selectors includes: #andNow:hasNew:keywordNames:).
	self assert: (testClass sourceCodeAt: #andNow:hasNew:keywordNames:) = 'andNow: firstPar hasNew: secondPar keywordNames: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass new andNow: 10 hasNew: 11 keywordNames: 21) = 42).
	
test11shouldRenameNonUsedClassMethod
	testClass class compile: 'classMethodToRename ^2+3'.
	self assert: (testClass class selectors includes: #classMethodToRename).
	self deny: (testClass class selectors includes: #methodRenamed).
	testClass class renameMethod: #classMethodToRename to: #methodRenamed.
	self deny: (testClass class selectors includes: #classMethodToRename).
	self assert: (testClass class selectors includes: #methodRenamed).
	self assert: (testClass class sourceCodeAt: #methodRenamed) = 'methodRenamed ^2+3'.
	self assert: (testClass methodRenamed = 5).
	
test12shouldRenameNonUsedClassMethodWithMultipleKeywords
	testClass class compile: 'thisIsAClassMethod: firstPar thatIsUsing: secondPar manyParameters: thirdPar ^firstPar + secondPar + thirdPar'.
	self assert: (testClass class selectors includes: #thisIsAClassMethod:thatIsUsing:manyParameters:).
	self deny: (testClass class selectors includes: #theClassMethod:hasBeen:renamedAllKeywords:).
	testClass class renameMethod: #thisIsAClassMethod:thatIsUsing:manyParameters: to: #theClassMethod:hasBeen:renamedAllKeywords:.
	self deny: (testClass class selectors includes: #thisIsAClassMethod:thatIsUsing:manyParameters:).
	self assert: (testClass class selectors includes: #theClassMethod:hasBeen:renamedAllKeywords:).
	self assert: (testClass class sourceCodeAt: #theClassMethod:hasBeen:renamedAllKeywords:) = 'theClassMethod: firstPar hasBeen: secondPar renamedAllKeywords: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: ((testClass theClassMethod: 3 hasBeen: 4 renamedAllKeywords: 5) = 12).
	
test13shouldRenameUsedClassMethod
	|tclass |
	tclass := testClass class .
	tclass compile: 'classMethodToUse ^9'.
	tclass compile: 'methodThatUsed ^self classMethodToUse'.
	self assert: (tclass selectors includes: #classMethodToUse).
	self deny: (tclass selectors includes: #afterRenaming).
	tclass renameMethod: #classMethodToUse to: #afterRenaming.
	self deny: (tclass selectors includes: #classMethodToUse).
	self assert: (tclass selectors includes: #afterRenaming).
	self assert: (tclass sourceCodeAt: #afterRenaming) = 'afterRenaming ^9'.
	self assert: (testClass afterRenaming = 9).
	
test14shouldRenameUsedClassMethodWithMultipleKeywords
	|tclass|
	tclass := testClass class.
	tclass compile: 'iAmUsing: firstPar threeDifferent: secondPar keywordsClassMethod: thirdPar ^firstPar + secondPar + thirdPar'.
	tclass compile: 'userMethod ^self iAmUsing: 10 threeDifferent: 20 keywordsClassMethod: 30'.
	self assert: (tclass selectors includes: #iAmUsing:threeDifferent:keywordsClassMethod:).
	self deny: (tclass selectors includes: #renamedBut:stillTakes:threeParams:).
	tclass renameMethod: #iAmUsing:threeDifferent:keywordsClassMethod: to: #renamedBut:stillTakes:threeParams:.
	self deny: (tclass selectors includes: #iAmUsing:threeDifferent:keywordsClassMethod:).
	self assert: (tclass selectors includes: #renamedBut:stillTakes:threeParams:).
	self assert: (tclass sourceCodeAt: #renamedBut:stillTakes:threeParams:) = 'renamedBut: firstPar stillTakes: secondPar threeParams: thirdPar  ^firstPar + secondPar + thirdPar'.
	self assert: (testClass userMethod = 60)