global therepeat
global theindex
global thenamingConvention
global integertype

property myScript : load script (alias "Macintosh HD:Users:kylestephens:desktop:AppleScripts:config.scpt")

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

on fabricateCues(therepeat, theindex, thenamingConvention, integertype) -- as number, as number, as string, 1 or 1.0
	tell application id "com.figure53.qlab.4" 

	activate

	try
        set workspaceName to q number of front workspace -- This actually gets the name of the workspace
    on error
        display dialog "There is no workspace open in QLab." with title dialogTitle with icon 0 buttons {"OK"} default button "OK" giving up after 5
        return
    end try
	
	end tell 
	

end fabricateCues

-- start of stuff
set fileType to choose from list showFileTypes
	if fileType is false then
	return

	else if item 1 of fileType is "ShowType 1" then
	loadTypes() --Gathers UserInput
	fabricateCues(therepeat, theindex, thenamingConvention, integertype) --Passes the values thru

	else if item 1 of fileType is "Default" then

	display dialog fileType
	else if item 1 of fileType is "Blank" then

	display dialog fileType
	end if


tell application id "com.figure53.qlab.4" to tell front workspace
	display dialog (name of workspace)
	end tell	

--tell front workspace
--





