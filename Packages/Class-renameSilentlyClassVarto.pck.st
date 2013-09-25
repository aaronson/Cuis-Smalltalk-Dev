'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 25 September 2013 at 1:46:40.203 am'!

!Class methodsFor: 'class variables' stamp: 'NR 9/25/2013 01:32'!
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
	self removeClassVarName: oldName.
! !
