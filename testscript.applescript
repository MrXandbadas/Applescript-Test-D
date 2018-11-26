global therepeat
global theindex
global thenamingConvention
global integertype
global workspaceFolderUI

property myScript : load script (alias "Macintosh HD:Users:kylestephens:desktop:AppleScripts:UserInterface.scpt")
property SFXImport : load script (alias "Macintosh HD:Users:kylestephens:desktop:AppleScripts:SFXAssetBuild.scpt")

set showFileTypes to {"ShowType 1", "Default", "Blank"}

on startQlab()
	tell application id "com.figure53.qlab.4" to activate
	delay 3
end startQlab
on loadTypes()
	tell myScript
		set newIndex to 0
		set myList to UI1() -- user interface 1
		repeat with theItem in myList
			-- display dialog (theItem & " " & newIndex) as string
			if newIndex is 0 then
				set therepeat to theItem -- Number
			else if newIndex is 1 then
				set theindex to theItem -- Number
			else if newIndex is 2 then
				set thenamingConvention to theItem -- String
			else if newIndex is 3 then
				set integertype to theItem -- 1 or 1.0
			else if newIndex is 4 then 
				set workspaceFolderUI to theItem -- True or False
			end if
			set newIndex to newIndex + 1
		end repeat
		-- {{therepeat}, {theindex}, {thenamingConvention}, {integertype}}
	end tell
	
end loadTypes

on fabricateCues(therepeat, theindex, thenamingConvention, integertype) -- as number, as number, as string, 1 or 1.0
	
	
	
end fabricateCues

-- start of stuff
set fileType to choose from list showFileTypes
if fileType is false then
	return
	
else if item 1 of fileType is "ShowType 1" then
	loadTypes() --Gathers UserInput
	fabricateCues(therepeat, theindex, thenamingConvention, integertype) --Passes the values thru
	tell SFXImport
		SFXAssetBuild(workspaceFolderUI) -- passing true or false because the folder is in the workspace
	end tell
	-- tell application "Finder" to save workspace in file resultFile
	
else if item 1 of fileType is "Default" then
	
	display dialog fileType
else if item 1 of fileType is "Blank" then
	
	display dialog fileType
end if



--tell front workspace
--




