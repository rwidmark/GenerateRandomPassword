
function New-RSRandomPassword {
    <#
        .SYNOPSIS
        Generate and returns a random password that includes numbers, letters and special characters.

        .DESCRIPTION
        This module generates and returns a random password that contains lower and upper letters, numbers and special characters.
        It can either generate one with the default options that are 12 characters long and contains 3 special characters,
        or you can decide how long the password should be and how many special characters it should contain.

        .PARAMETER Length
        Specify how many characters you want your password to be.
        Default is 12, shortest length is 6 and max length is 30.

        .PARAMETER SpecialCharacters
        Specify how many special characters your password will has in it.
        Default is 3, shortest length is 1 and max length is 15.

        .EXAMPLE
        New-RSRandomPassword
        # Returns a random password that are 12 characters long and contains 1 special character.

        .EXAMPLE
        New-RSRandomPassword -Length 20 -SpecialCharacters 4
        # Returns a random password that are 20 characters long and contains 4 special character.

        .NOTES
        Author:         Robin Widmark
        Mail:           robin@widmark.dev
        Website/Blog:   https://widmark.dev
        X:              https://x.com/widmark_robin
        Mastodon:       https://mastodon.social/@rwidmark
		YouTube:		https://www.youtube.com/@rwidmark
        Linkedin:       https://www.linkedin.com/in/rwidmark/
        GitHub:         https://github.com/rwidmark
    #>

    [CmdletBinding()]
    param(
        [ValidateRange(6, 30)]
        [Parameter(Mandatory = $false, HelpMessage = "Specify how many character the password should contain")]
        [int]$Length = 12,
        [ValidateRange(1, 15)]
        [Parameter(Mandatory = $false, HelpMessage = "Specify how many special characters the password should conatin")]
        [int]$SpecialCharacters = 3
    )

    $Character = 'abcdefghiklmnoprstuvwxyzABCDEFGHKLMNOPRSTUVWXYZ1234567890'
    $RandomCharacter = 1..$($Length - $SpecialCharacters) | ForEach-Object {
        Get-Random -Maximum $Character.length
    }


    $SpecialCharacter = '!@#$%^&.,_*()=+*?-'
    $RandomSpecialC = 1..$SpecialCharacters | ForEach-Object {
        Get-Random -Maximum $SpecialCharacter.length
    }

    $private:ofs = ""
    $inputString = [String]$Character[$RandomCharacter]
    $inputString += [String]$SpecialCharacter[$RandomSpecialC]

    $characterArray = $inputString.ToCharArray()
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length
    $outputString = -join $scrambledStringArray
    return $outputString
}