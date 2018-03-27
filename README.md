# GistCommenter #

## Requirements ##

- Swift 4.0.2+
- [xcpretty](https://github.com/supermarin/xcpretty) - a fast and flexible formatter for xcodebuild
- [Carthage](https://github.com/Carthage/Carthage) - A simple, decentralized dependency manager for Cocoa


## Under the hood ##

If you plan to change work on the source code you will probably need:

- [SwiftLint](https://github.com/realm/SwiftLint)
- [SwiftGen](https://github.com/SwiftGen/SwiftGen)
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

## Setup ##

__Be prepared__, this project uses Carthage and will build all libraries as frameworks. Go grab a coffee and wait.

Run `bin/setup`

This will:

1. Run `carthage update --verbose --platform iOS`

## Testing ##

I'll finish writting all tests later... but in a perfect world you would run

`bin/test`

This will run the tests from the command line, and pipe the result through
[XCPretty][].

[XCPretty]: https://github.com/supermarin/xcpretty

**Note** - You don't have access to the camera in the first controller. So i've wrote a sample mock to test it.

**Note 2:** In the folder SampleData inside Resources you will find qr code images to validate the app.