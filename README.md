<p align="center">
<img src="./jpg/Typeset.png">
</p>

<p align="center">
[![Version](http://img.shields.io/cocoapods/v/Typeset.svg?style=flat)](http://cocoadocs.org/docsets/Typeset) [![Build Status](https://travis-ci.org/Draveness/Typeset.svg?branch=1.0.0)](https://travis-ci.org/Draveness/Typeset) ![MIT License](https://img.shields.io/github/license/mashape/apistatus.svg) ![Platform](https://img.shields.io/badge/platform-%20iOS%20-lightgrey.svg)

----


Typeset makes it easy to create `NSAttributedString`

```
@"Hello typeset".typeset
   .match(@"Hello").fontSize(40)
   .match(@"type").purple
   .match(@"set").blue
   .string;
```

# Usage

+ Method chaining
	+ All the method for typeset returns a `self` object to chaining itself.

		```
		@"Hello typeset".typeset
		   .match(@"Hello").fontSize(40)
		   .match(@"type").purple
		   .match(@"set").blue
		   .string;
		```
		
	> call `typeset` method first and call `string` at last returns a `NSAttributedString`.
		
+ UILabel support
	+ Add `typesetBlock` to UILabel, and you can directly set it's text style with:

	```objectivec
	label.typesetBlock = TSBlock(fontSize(40)
	                       .match(@"type").purple
	                       .match(@"set").blue);
	label.text = @"Hello typeset, hello.";
	```

## References

### Attributes

| Dictionary Key                      | `Typeset` Method                                       |
| ----------------------------------- | ------------------------------------------------------ |
| `NSFontAttributeName`               | `font(UIFont font)`                                    |
|                                     | `fontSize(CGFloat size)`                               |
|                                     | `fontName(NSString name)`                              |
| `NSForegroundColorAttributeName`    | `color(UIColor color)`                                 |
|                                     | `hexColor(CGFloat hexColor)`                           |
| `NSKernAttributeName`               | `kern(CGFloat kern)`                                   |
| `NSUnderlineStyleAttributeName`     | `underline(TSUnderline underline)`                     |
| `NSBaselineOffsetAttributeName`     | `baseline(CGFloat baseline)`                           |
| `NSStrikethroughStyleAttributeName` | `strikeThrough(TSStrikeThrough strikeThrough)`         |
| `NSParagraphStyleAttributeName`     | `lineBreakMode(NSLineBreakMode lineBreakMode)`         |
|                                     | `textAlignment(NSTextAlignment textAlignment)`         |
|                                     | `lineSpacing(CGFloat lineSpacing)`                     |


## Installation 

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like DKNightVersion in your projects. See the [Get Started section](https://cocoapods.org/#get_started) for more details.

## Podfile

```
pod "Typeset"
```

## Colorize

If you want to colorize a literal string to red.
 
```objectivec
@"Hello".typeset.red.string;
```

This will return a `NSMutableAttributedString with red color.

Typeset also provide a neat way to do this.

```objectivec
// The same as '@"Hello".typeset.red.string;'
@"Hello".red;
@"Hello".green;
@"Hello".color([UIColor whiteColor]);
@"Hello".hexColor(0x313131);
```

Typeset providing all the built-in colors in UIKit. So you can use them easily.

```objectivec
- (TypesetKit *)black;
- (TypesetKit *)darkGray;
- (TypesetKit *)lightGray;
- (TypesetKit *)white;
- (TypesetKit *)gray;
- (TypesetKit *)red;
- (TypesetKit *)green;
- (TypesetKit *)blue;
- (TypesetKit *)cyan;
- (TypesetKit *)yellow;
- (TypesetKit *)magenta;
- (TypesetKit *)orange;
- (TypesetKit *)purple;
- (TypesetKit *)brown;
- (TypesetKit *)clear;

- (TypesettingColorBlock)color;
- (TypesettingIntegerBlock)hexColor; // @"string".typeset.hexColor(0xffffff).string
```


## Font

```objectivec
- (TypesettingStringBlock)fontName;
- (TypesettingCGFloatBlock)fontSize;
- (TypesettingFontBlock)font;

- (TypesetKit *)regular;
- (TypesetKit *)light;
- (TypesetKit *)bold;
- (TypesetKit *)italic;
- (TypesetKit *)thin;
```

Use `fontSize(size)` `fontName(name)` to change a string's font size or name.

```objectivec
@"Hello".typeset.fontSize(40.0).string;
@"Hello".typeset.fontName(@"Helvetica").string;
```

If you want to change both font size or name, use `font(name, size)`.

```objectivec
@"Hello".typeset.font(@"Helvetica, 40.0).string;
@"Hello".font(@"Helvetica, 40.0);
```

## Match Part of String

Typeset change total string by default. But you can use these method to change part of string.

* `from(i)` `to(i)` 
* `location(i)` `length(i)` 
* `range(range)`
* `match(string)` 
* `matchAll(string)`

If you want to change `He` of `Hello` to red.

```objectivec
@"Hello".typeset.from(0).to(2).red.string;
@"Hello".typeset.location(0).length(2).red.string;
@"Hello".typeset.range(NSMakeRange(0,2)).red.string;
@"Hello".typeset.match(@"He").red.string;
```

> `match` method match the first pattern appear in the 
> string, if you want to customize mutiple pattern, you should
> not use this method.

## Append

Typeset provide a more elegant method `append` to concat mutiple `NSMutableAttributedString`.

```objectivec
mas.append(mas).append(mas);
```

## Style

```objectivec
- (TypesettingStrikeThroughBlock)strikeThrough;

- (TypesettingBaselineBlock)baseline;

- (TypesettingIntegerBlock)underline;

- (TypesettingStringBlock)link;

- (TypesettingStringBlock)append;

- (TypesettingIntegerBlock)ligature;

- (TypesettingCGFloatBlock)kern;

- (TypesettingIntegerBlock)lineBreakMode;

- (TypesettingIntegerBlock)textAlignment;

- (TypesettingCGFloatBlock)lineSpacing;
```

### Underline

Use `underline(style)` adding underline to string.

```objectivec
@"Hello".typeset.underline(NSUnderlineStyleSingle).string;
```

# Contribute

Feel free to open an issue or pull request, if you need help or there is a bug.

# Contact

- Powered by [Draveness](http://github.com/draveness)

# License

Typeset is available under the MIT license. See the LICENSE file for more info.

# Todo

- Documentation
- More features

