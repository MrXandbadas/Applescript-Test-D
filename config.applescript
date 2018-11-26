on UI1()
	display dialog "Number of cues to generate:" default answer "100"
	if button returned of result = "cancel" then
		return
	else
		
		set therepeat to (text returned of result) as integer
	end if
	
	display dialog "Starting value for variable?" default answer "1"
	if button returned of result = "cancel" then
		return
	else
		
		set theindex to (text returned of result) as real
	end if
	display dialog "Integer value format" buttons {"1", "1.0"} default button "1"
	set integertype to button returned of result
	display dialog "Naming Convention for Cues:" default answer "" buttons {"panic", "GO"} default button "GO"
	if button returned of result is "panic" then
		return
	else
		set thenamingConvention to (text returned of result) as string
	end if
	display dialog "Welcome Weary Tech Guru,
Your travels have goten you far. Far enough for computers to undercut
even some of our handy work. All will not be forgotten! 
There is still plenty to do!


Please ensure all information is correct:
Cues: " & therepeat & "
Naming Standard: " & thenamingConvention & "
Cue Integer Standard: " & integertype & " 
Information correct?" with icon caution buttons {"Yes", "No"} default button "No"
	
	if button returned of result is "No" then
		display dialog "Are you sure?" buttons {"Yes", "No"} default button "No"
		if button returned of result is "Yes" then
			return "restart"
			--Clear out stuff, start again
		else
			
			-- Go back to the confirming information screen
			
		end if
	end if
	return {{therepeat}, {theindex}, {thenamingConvention}, {integertype}}
end UI1