

on SFXAssetBuild(userWatchedFolderIsNextToWorkspace)

set userWatchedFolder to "SFX" -- Set the name of the watched folder (or change this to a full POSIX path if you change the above to false)
set userWatchedCuelist to "Main Cue List" -- Set the name of the cuelist for automatically-generated cues
set userFlagNewCues to false -- Flag any automatically-generated cues?

-- Declarations

global dialogTitle
set dialogTitle to "Scan for files"

set audioFileTypes to {"com.apple.coreaudio-format", "com.apple.m4a-audio", "com.microsoft.waveform-audio", "public.aifc-audio", "public.aiff-audio", "com.apple.protected-mpeg-4-audio", ¬
	"public.audio", "public.mp3", "public.mpeg-4-audio"}
(* This list deliberately excludes "com.apple.protected-mpeg-4-audio" to protect against old DRM-restricted iTunes files *)

set cuesAdded to 0

-- Main routine

tell application id "com.figure53.qlab.4" to tell front workspace
	
	-- Locate the watched folder
	
	
	if userWatchedFolderIsNextToWorkspace then
		
		
		-- Establish the path to the current workspace
		
		
		set workspacePath to path
		if workspacePath is missing value then
		set resultFile to (choose file name with prompt "Save As File" default name "My File" default location path to desktop) as text
		save workspace as resultFile
			--display dialog "The current workspace has not yet been saved anywhere.
			--Please save the workspace and try again" with title dialogTitle with icon 0 ¬
				--buttons {"OK"} default button "OK"

			return
		end if
		
		
		-- Get the path to the watched folder
		
		
		tell application "System Events"
			set watchedFolder to path of container of file workspacePath & userWatchedFolder
		end tell
		
		
	else
		
		
		set watchedFolder to userWatchedFolder
		
		
	end if
	
	
	-- Check watched folder exists
	
	
	tell application "System Events" to set folderExists to exists folder watchedFolder
	
	
	if not folderExists then
		display dialog "The watched folder \"" & POSIX path of watchedFolder & "\" does not exist." with title dialogTitle with icon 0 ¬
			buttons {"OK"} default button "OK"
		return
	end if
	
	
	-- Check watched cuelist exists
	
	
	try
	
		set watchedCuelist to first cue list whose q name is ("SFX Assets")
		
	on error
		try
		make type "cue list"
			set sfxCueGroup to first cue list whose q name is ("Cue List")
			set the q name of sfxCueGroup to "SFX Assets"
			set the q color of sfxCueGroup to "Green"
			set watchedCuelist to first cue list whose q name is ("SFX Assets")
			on error
			display dialog "Error Making the CueList" with title dialogTitle with icon 0
			return
			end try
	end try
	
	
	
	
	-- Replicate file structure
	
	
	set theFolders to {POSIX path of watchedFolder}
	set countFolders to count theFolders
	set parentFolders to {}
	set i to 0
	
	
	set currentTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "/"
	
	
	repeat until i = countFolders
		
		
		set eachFolder to item (i + 1) of theFolders
		
		
		-- Record the parent of each folder processed
		
		
		if i = 0 then
			set end of parentFolders to last text item of eachFolder
		else
			set end of parentFolders to text item -2 of eachFolder
		end if
		
		
		-- Make a list of all Group Cues in the watched cuelist
		
		
		set existingGroups to cues of watchedCuelist whose q type is "Group"
		set countExistingGroups to count existingGroups
		set j to 0
		
		
		repeat until j = countExistingGroups
			try
				set existingGroups to existingGroups & (cues of item (j + 1) of existingGroups whose q type is "Group")
			end try
			set j to j + 1
			set countExistingGroups to count existingGroups
		end repeat
		
		
		-- Find first Group Cue whose name matches
		
		
		set makeNextCueIn to current cue list -- If there is no match, new cues will be added directly to the cue list
		repeat with eachGroup in existingGroups
			if q name of eachGroup is item (i + 1) of parentFolders then
				set makeNextCueIn to eachGroup
				exit repeat
			end if
		end repeat
		
		
		-- Move the selection to set where the next cue will be made
		
		
		try
			set selected to last item of (cues of makeNextCueIn)
		on error
			set current cue list to watchedCuelist
		end try
		
		
		-- Make Group Cues if needed
		
		
		if i = 0 then
			set currentGroup to watchedCuelist
		else
			set groupName to last text item of eachFolder
			set currentGroup to false
			repeat with eachGroup in existingGroups
				if q name of eachGroup is groupName then
					set currentGroup to eachGroup
					exit repeat
				end if
			end repeat
			if currentGroup is false then
				make type "Group"
				set cuesAdded to cuesAdded + 1
				set newCue to last item of (selected as list)
				if userFlagNewCues then set flagged of newCue to true
				set q name of newCue to groupName
				set currentGroup to newCue
			end if
		end if
		
		
		-- Make a list of files already used in the current Group Cue
		
		
		set existingTargets to file target of cues of currentGroup whose broken is false and q type is "Audio"
		set usedFiles to {}
		repeat with eachTarget in existingTargets
			set end of usedFiles to POSIX path of eachTarget
		end repeat
		
		
		-- Get files of folder to be processed
		
		
		tell application "System Events" to set theFiles to POSIX path of disk items of folder eachFolder whose visible is true
		
		
		-- Process them: if folder, add to list for processing; if file, make a cue if needed
		
		
		repeat with eachFile in theFiles
			
			
			try -- This detects folders
				tell application "System Events"
					set eachType to type identifier of file eachFile
				end tell
				if eachType is in audioFileTypes and eachFile is not in usedFiles then
					make type "Audio"
					set cuesAdded to cuesAdded + 1
					set newCue to last item of (selected as list)
					if userFlagNewCues then set flagged of newCue to true
					set file target of newCue to eachFile
					if parent of newCue is not currentGroup then -- Will need to move first cue made if Group Cue was empty
						set newCueID to uniqueID of newCue
						move cue id newCueID of parent of newCue to end of currentGroup
						set selected to newCue
					end if
				end if
			on error
				set theFolders to theFolders & eachFile
			end try
			
			
		end repeat
		
		
		set i to i + 1
		set countFolders to count theFolders
		
		
	end repeat
	
	
	set AppleScript's text item delimiters to currentTIDs
	
	
	-- Report how many cues added
	
	
	if cuesAdded = 0 then
		set theMessage to "No cues were added."
	else if cuesAdded = 1 then
		set theMessage to "1 cue was added."
	else
		set theMessage to (cuesAdded & " cues were added.") as text
	end if
	
	
	display dialog theMessage with title dialogTitle with icon 1 ¬
		buttons {"OK"} default button "OK" giving up after 5
	
	
end tell

end SFXAssetBuild
