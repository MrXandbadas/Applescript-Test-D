

on loadAssets(userCopyOnImport, newTargets) -- Please give me {T/F, {choose file return}}

    set userReassuranceThreshold to 5

    --dec

    global sharedPath

    set audioFileTypes to {"com.apple.coreaudio-format", "com.apple.m4a-audio", "com.microsoft.waveform-audio", "public.aifc-audio", "public.aiff-audio", "com.apple.protected-mpeg-4-audio", "public.audio", "public.mp3", "public.mpeg-4-audio"}
	(* This list deliberately excludes "com.apple.protected-mpeg-4-audio" to protect against old DRM-restricted iTunes files *)
	
    set videoFileTypes to {"com.apple.icns", "com.apple.macpaint-image", "com.apple.pict", "com.apple.quicktime-image", "com.apple.quicktime-movie", "public.3gpp", "public.3gpp2", "public.avi", "public.camera-raw-image", "public.image", "public.jpeg", "public.jpeg-2000", "public.movie", "public.mpeg", "public.mpeg-4", "public.png", "public.tiff", "public.video", "public.xbitmap-image"}
    -- Apparently not 100% Tested..

    set theFileTypes to {audioFileTypes, videoFileTypes}
    set foldersExist to {null, null}
    set theSubfolders to {"SFX Assets", "Visual Assets"}
    set theCueTypes to {"Audio", "Video"}

    set cuesAdded to 0
    -- Main routine

    tell front workspace
            --Get path
            set workspacePath to path
                if workspacePath is missing value then
                    set x to true
                    save
                    repeat while x
                    delay 5
                    set workspacePath to path
                    if workspacePath is not missing value then
                        set x to false
                    end if
                    --Not sure if I should put a timeout function in to actually stop this loop incase we no save...
                    end repeat
                end if

                -- Get the path that should prefix all media file paths

                tell application "System Events"
                    set watchedFolder to path of container of file workspacePath
                end tell


        -- testing

          repeat with eachFile in newTargets

                tell application "System Events"
                    set eachType to type identifier of eachFile
                    set eachName to name of eachFile
                end tell

                -- work through the types of cues

                repeat with i from 1 to 2
                    if eachType is in contents of item i of theFileTypes then

                            -- If copying is specified by the user definitions then…

                            -- Check for appropriate subfolder next to workspace and make it if it doesn't exist

                            if item i of foldersExist is null then
                                set item i of foldersExist to my checkForFolder(item i of theSubfolders)
                                if item i of foldersExist is false then
                                    my makeFolder(item i of theSubfolders)
                                end if
                            end if

                            -- If the file is not already in place, copy it to the appropriate subfolder

                            if my checkForFile(item i of theSubfolders, eachName) is false then
                                my copyFile(item i of theSubfolders, eachFile)
                            end if

                            set eachTarget to sharedPath & item i of theSubfolders & ":" & eachName

                        

                            make type item i of theCueTypes
                            set newCue to last item of (selected as list)
                            set file target of newCue to eachTarget
                            set q name of newCue to eachName

                        exit repeat

                     end if
                end repeat

            end repeat

        end tell
        


end loadAssets