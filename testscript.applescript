global therepeat
global theindex
global thenamingConvention
global integertype

property myScript : load script (alias "Macintosh HD:Users:kylestephens:desktop:AppleScripts:config.scpt")

set showFileTypes to {"ShowType 1", "Default", "Blank"}


on loadTypes()
	tell myScript
		set newIndex to 0
		set myList to UI1() -- user interface 1
		repeat with theItem in myList
			-- display dialog (theItem & " " & newIndex) as string
			if newIndex is 0 then
				set therepeat to theItem
			else if newIndex is 1 then
				set theindex to theItem
			else if newIndex is 2 then
				set thenamingConvention to theItem
			else if newIndex is 3 then
				set integertype to theItem	
			end if
			set newIndex to newIndex + 1
		end repeat
		-- {{therepeat}, {theindex}, {thenamingConvention}, {integertype}}
	end tell

end loadTypes

-- start of stuff
set fileType to choose from list showFileTypes
if item 1 of fileType is "ShowType 1" then
	display dialog fileType
	else if item 1 of fileType is "Default" then
	display dialog fileType
	if item 1 of fileType is "Blank" then
	display dialog fileType
loadTypes()


tell application id "com.figure53.qlab.4" to activate
tell front workspace
	display dialog (name of workspace)
	end tell	

--tell front workspace
--





