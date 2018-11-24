
on begin()
set otherScript to "config.spct"
tell application "Finder"
	set otherScript to ("Macintosh HD:Users:kylestephens:Documents/config.spct") as string

	-- set otherScript to (_otherScript & otherScript) as string

end tell

--if (path to me as string) ends with ":" then
--set otherScript to
	--(path to resource otherScript in directory "Scripts") as string
--else
	--set otherScript to
		--(container of (path to me)) as string & otherScript
set model to load script file otherScript
display dialog otherScript

--end if
end begin
begin()
model gatherInformation()




-- Gathering the information above

-- confirming information


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
	--Clear out stuff, start again
	else
	-- Go back to the confirming information screen

end if
end if




