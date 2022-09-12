// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum DetailViewController {
    /// Movie Name:
    public static let movieName = L10n.tr("Localizable", "DetailViewController.movieName", fallback: "Movie Name:")
    /// Movie Type:
    public static let movieType = L10n.tr("Localizable", "DetailViewController.movieType", fallback: "Movie Type:")
    /// Movie Year:
    public static let movieYear = L10n.tr("Localizable", "DetailViewController.movieYear", fallback: "Movie Year:")
  }
  public enum HomeViewController {
    /// SEARCH
    public static let searchButtonTitle = L10n.tr("Localizable", "HomeViewController.searchButtonTitle", fallback: "SEARCH")
    /// Search...
    public static let searchPlaceholder = L10n.tr("Localizable", "HomeViewController.searchPlaceholder", fallback: "Search...")
  }
  public enum SplashViewController {
    /// Localizable.strings
    ///   UIComponents
    /// 
    ///  //  Created by Amber Çatalbaş on 10.09.2022.
    public static let disconnect = L10n.tr("Localizable", "SplashViewController.disconnect", fallback: "You are not connected to the internet")
    /// Try Again
    public static let tryAgain = L10n.tr("Localizable", "SplashViewController.tryAgain", fallback: "Try Again")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
