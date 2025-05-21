![GitHub](https://img.shields.io/github/license/rwidmark/GenerateRandomPassword?style=plastic)  
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/rwidmark/GenerateRandomPassword?sort=semver&style=plastic)  ![Last release](https://img.shields.io/github/release-date/rwidmark/GenerateRandomPassword?style=plastic)
![GitHub last commit](https://img.shields.io/github/last-commit/rwidmark/GenerateRandomPassword?style=plastic)  
![PSGallery downloads](https://img.shields.io/powershellgallery/dt/GenerateRandomPassword?style=plastic)

# GenerateRandomPassword
This module generates and returns a random password that contains lower and upper letters, numbers and special characters.  
It can either generate one with the default options that are 12 characters long and contains 3 special characters,  
or you can decide how long the password should be and how many special characters it should contain.  
I have added the result from PSScriptAnalyzer in [test folder](https://github.com/rwidmark/GenerateRandomPassword/tree/main/test)

# Links
* [My PowerShell Collection](https://github.com/rwidmark/PSCollection)
* [Webpage/Blog](https://widmark.dev)
* [X](https://twitter.com/widmark_robin)
* [Mastodon](https://mastodon.social/@rwidmark)
* [YouTube](https://www.youtube.com/@rwidmark)
* [LinkedIn](https://www.linkedin.com/in/rwidmark/)
* [GitHub](https://github.com/rwidmark)

# Help
Below I have specified things that I think will help people with this module.  
You can also see the API for each function in the [help folder](https://github.com/rwidmark/GenerateRandomPassword/tree/main/help)

## Install
Install for current user
````
Install-Module -Name GenerateRandomPassword -Scope CurrentUser -Force
````

Install for all users
````
Install-Module -Name GenerateRandomPassword -Scope AllUsers -Force
````

## Example
````
New-RSRandomPassword
````
Returns a random password that are 12 characters long and contains 1 special character.
````
New-RSRandomPassword -Length 20 -SpecialCharacters 4
````
Returns a random password that are 20 characters long and contains 4 special character.