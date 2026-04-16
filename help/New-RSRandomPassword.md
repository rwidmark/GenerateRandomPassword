NAME
    New-RSRandomPassword
    
SYNOPSIS
    Generate and returns a random password that includes numbers, letters and special characters.
    
    
SYNTAX
    New-RSRandomPassword [[-Length] <Int32>] [[-SpecialCharacters] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
    
    
DESCRIPTION
    This module generates and returns a random password that contains lower and upper letters, numbers and special characters.
    It can either generate one with the default options that are 12 characters long and contains 3 special characters,
    or you can decide how long the password should be and how many special characters it should contain.
    

PARAMETERS
    -Length <Int32>
        Specify how many characters you want your password to be.
        Default is 12, shortest length is 6 and max length is 30.
        
        Required?                    false
        Position?                    1
        Default value                12
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    -SpecialCharacters <Int32>
        Specify how many special characters your password will has in it.
        Default is 3, shortest length is 1 and max length is 15.
        The value must also be smaller than Length.
        
        Required?                    false
        Position?                    2
        Default value                3
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        InformationAction, InformationVariable, OutBuffer,
        PipelineVariable, OutVariable, WhatIf, and Confirm. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    String
    
NOTES
    
    
        Author:         Robin Widmark
        Mail:           robin@widmark.dev
        Website/Blog:   https://widmark.dev
        X:              https://x.com/widmark_robin
        Mastodon:       https://mastodon.social/@rwidmark
        YouTube:        https://www.youtube.com/@rwidmark
        Linkedin:       https://www.linkedin.com/in/rwidmark/
        GitHub:         https://github.com/rwidmark
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS > New-RSRandomPassword
    # Returns a random password that is 12 characters long and contains 3 special characters.
    
    
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS > New-RSRandomPassword -Length 20 -SpecialCharacters 4
    # Returns a random password that is 20 characters long and contains 4 special characters.
    
    
    
    
    
    
    -------------------------- EXAMPLE 3 --------------------------
    
    PS > New-RSRandomPassword -Verbose
    # Returns a random password and writes verbose details about the generated composition.
    
    
    
    
    
    
    -------------------------- EXAMPLE 4 --------------------------
    
    PS > New-RSRandomPassword -WhatIf
    # Shows what would happen without generating a password.
    
    
    
    
    
    
RELATED LINKS

