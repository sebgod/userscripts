﻿using System;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    static class PhoneNumberParsingHelper {

        public static bool TryParsePhoneInput(string userInput, out ParsedUserInput parsedUserInput)
        {
            string numberOrName;
            Uri uri;
            if (string.IsNullOrEmpty(userInput)
                || !Uri.TryCreate(userInput, UriKind.Absolute, out uri)
                || string.IsNullOrEmpty(numberOrName = uri.GetComponents(UriComponents.Path, UriFormat.Unescaped).Trim())
                )
            {
                parsedUserInput = default(ParsedUserInput);
                return false;
            }

            var startsWithPlusOrParen = "+(".IndexOf(numberOrName[0]) >= 0;
            var startsWithDigit = char.IsDigit(numberOrName, 0);
            var endsWithDigit = char.IsDigit(numberOrName, numberOrName.Length - 1);
            parsedUserInput = new ParsedUserInput(numberOrName,
                                                  (startsWithDigit || startsWithPlusOrParen) && endsWithDigit
                                                      ? UserInputType.PhoneNumberLike
                                                      : UserInputType.NamePartLike);
            return !parsedUserInput.IsEmptyOrUnknown;
        }

        public static ParsedUserInput CleanupPhoneUserInput(this string userInput)
        {
            return new ParsedUserInput(userInput, UserInputType.PhoneNumberLike).CleanupPhoneUserInput();
        }
        public static ParsedUserInput CleanupPhoneUserInput(this ParsedUserInput userInput)
        {
            switch (userInput.InputType)
            {
                case UserInputType.PhoneNumberLike:
                    uint exceptCount;
                    var stripped = userInput.ToString().StripAllNonDigitsExcept('+', out exceptCount);
                    string numberString;
                    if (exceptCount > 0)
                    {
                        var removedLeadingPlus = stripped[0] == '+' ? "00" + stripped.Substring(1) : stripped;
                        numberString = exceptCount > 1 ? removedLeadingPlus.StripAllNonDigits() : removedLeadingPlus;
                    }
                    else
                    {
                        numberString = stripped;
                    }
                    return new ParsedUserInput(numberString, UserInputType.PhoneNumberLike, isCleanedUp: true);

                case UserInputType.NamePartLike:
                    return new ParsedUserInput(userInput.ToString().Trim(), UserInputType.NamePartLike);

                default:
                    return userInput;
            }
        }
    }
}