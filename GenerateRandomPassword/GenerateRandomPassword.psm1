$script:AlphaNumericCharacters = 'abcdefghiklmnoprstuvwxyzABCDEFGHKLMNOPRSTUVWXYZ1234567890'.ToCharArray()
$script:PasswordSpecialCharacters = '!@#$%^&.,_*()=+*?-'.ToCharArray()

function Get-RSRandomIndex {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Security.Cryptography.RandomNumberGenerator]$RandomNumberGenerator,

        [Parameter(Mandatory = $true)]
        [byte[]]$Buffer,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Maximum
    )

    $limit = [uint32]::MaxValue - ([uint32]::MaxValue % [uint32]$Maximum)

    do {
        $RandomNumberGenerator.GetBytes($Buffer)
        $randomValue = [System.BitConverter]::ToUInt32($Buffer, 0)
    } while ($randomValue -ge $limit)

    return [int]($randomValue % [uint32]$Maximum)
}

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
        The value must also be smaller than Length.

        .EXAMPLE
        New-RSRandomPassword
        # Returns a random password that is 12 characters long and contains 3 special characters.

        .EXAMPLE
        New-RSRandomPassword -Length 20 -SpecialCharacters 4
        # Returns a random password that is 20 characters long and contains 4 special characters.

        .EXAMPLE
        New-RSRandomPassword -Verbose
        # Returns a random password and writes verbose details about the generated composition.

        .EXAMPLE
        New-RSRandomPassword -WhatIf
        # Shows what would happen without generating a password.

        .NOTES
        Author:         Robin Widmark
        Mail:           robin@widmark.dev
        Website/Blog:   https://widmark.dev
        X:              https://x.com/widmark_robin
        Mastodon:       https://mastodon.social/@rwidmark
        YouTube:        https://www.youtube.com/@rwidmark
        Linkedin:       https://www.linkedin.com/in/rwidmark/
        GitHub:         https://github.com/rwidmark
    #>

    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([string])]
    param(
        [ValidateRange(6, 30)]
        [Parameter(Mandatory = $false, HelpMessage = 'Specify the total number of characters to include in the password.')]
        [int]$Length = 12,

        [ValidateRange(1, 15)]
        [Parameter(Mandatory = $false, HelpMessage = 'Specify how many special characters to include in the password.')]
        [int]$SpecialCharacters = 3
    )

    if ($SpecialCharacters -ge $Length) {
        $message = 'SpecialCharacters must be smaller than Length so the password contains at least one letter or number.'
        $exception = [System.ArgumentOutOfRangeException]::new('SpecialCharacters', $SpecialCharacters, $message)
        $errorRecord = [System.Management.Automation.ErrorRecord]::new(
            $exception,
            'SpecialCharactersMustBeSmallerThanLength',
            [System.Management.Automation.ErrorCategory]::InvalidData,
            $SpecialCharacters
        )

        $PSCmdlet.ThrowTerminatingError($errorRecord)
    }

    $action = "Generate a random password with length $Length and $SpecialCharacters special characters"
    if (-not $PSCmdlet.ShouldProcess('Random password output', $action)) {
        return
    }

    Write-Verbose "Generating a password with $Length characters and $SpecialCharacters special characters."

    $passwordCharacters = [char[]]::new($Length)
    $alphaNumericCount = $Length - $SpecialCharacters
    $randomNumberGenerator = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $randomBuffer = [byte[]]::new(4)

    try {
        for ($index = 0; $index -lt $alphaNumericCount; $index++) {
            $passwordCharacters[$index] = $script:AlphaNumericCharacters[
                (Get-RSRandomIndex -RandomNumberGenerator $randomNumberGenerator -Buffer $randomBuffer -Maximum $script:AlphaNumericCharacters.Length)
            ]
        }

        for ($index = $alphaNumericCount; $index -lt $Length; $index++) {
            $passwordCharacters[$index] = $script:PasswordSpecialCharacters[
                (Get-RSRandomIndex -RandomNumberGenerator $randomNumberGenerator -Buffer $randomBuffer -Maximum $script:PasswordSpecialCharacters.Length)
            ]
        }

        # Shuffle the generated characters in place to avoid extra arrays and pipeline overhead.
        for ($index = $passwordCharacters.Length - 1; $index -gt 0; $index--) {
            $swapIndex = Get-RSRandomIndex -RandomNumberGenerator $randomNumberGenerator -Buffer $randomBuffer -Maximum ($index + 1)

            if ($swapIndex -ne $index) {
                $character = $passwordCharacters[$index]
                $passwordCharacters[$index] = $passwordCharacters[$swapIndex]
                $passwordCharacters[$swapIndex] = $character
            }
        }
    }
    finally {
        $randomNumberGenerator.Dispose()
    }

    return [string]::new($passwordCharacters)
}
