'From Cuis 4.2 of 25 July 2013 [latest update: #1820] on 19 September 2013 at 9:33:51.79 pm'!

!Class methodsFor: 'class variables' stamp: 'NR 9/19/2013 20:58'!
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
	self removeClassVarName: oldName.
	self replaceSilently: oldName to: newName.	"replace in text body of all methods"! !
