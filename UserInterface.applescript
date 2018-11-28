global therepeat
global theindex
global thenamingConvention
global integertype
global workspaceFolderUI
--first thing yall see
on templateDisplay()
	display dialog "Hello there,
	This is the template Creator for a show that has:
	Visual Output
	Audio Output
	LX Output
	LX Live Control

	Is the show file going to be in the same folder as the Asset Folders?" buttons {"Cancel", "No", "Yes"} default button "No"
	if button returned of result = "cancel" then
		return false
	else if button returned of result = "No" then
		set workspaceFolderUI to false
	else if button returned of result = "Yes" then
		set workspaceFolderUI to true
	end if
	return true
end templateDisplay
-- Cues Definition
on cues()
	display dialog "Number of cues to generate:" default answer "100"
	if button returned of result = "cancel" then
		return
	else
		
		set therepeat to (text returned of result) as integer
	end if
end cues

--Starting Value
on startingValue()
	display dialog "Starting value for variable?" default answer "1"
	if button returned of result = "cancel" then
		return
	else
		
		set theindex to (text returned of result) as real
	end if
end startingValue

-- Integer
on integerVal()
	display dialog "Integer value format" buttons {"1", "1.0"} default button "1"
	set integertype to button returned of result
end integerVal

-- Naming Convention
on namingCon()
	display dialog "Naming Convention for Cues:" default answer "" buttons {"panic", "GO"} default button "GO"
	if button returned of result is "panic" then
		return
	else
		set thenamingConvention to (text returned of result) as string
	end if
end namingCon

--Info Checker
on infoChecker()
	display dialog "
Please ensure all information is correct:
Naming Standard: " & thenamingConvention & "
Cues: " & therepeat & "
Cue Integer Standard: " & integertype & " 

Information correct?" with icon caution buttons {"Yes", "No"} default button "No"
	
	if button returned of result is "No" then
		display dialog "Are you sure?" buttons {"Yes", "No"} default button "No"
		if button returned of result is "Yes" then
			return {restart}
			--Clear out stuff, start again
		else
			
			-- Go back to the confirming information screen
			
		end if
	end if
end infoChecker

on UI1()
	
	
	--Here is the script
	delay 3
	if templateDisplay() is true then
		cues()
		startingValue()
		integerVal()
		namingCon()
		delay 1
		infoChecker()
		return {{therepeat}, {theindex}, {thenamingConvention}, {integertype}, {workspaceFolderUI}}
	else
		display dialog "Got Canceled" buttons {"Okay"}
		return {false}
	end if
end UI1
