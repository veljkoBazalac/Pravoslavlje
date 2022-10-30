//
//  K.swift
//  Православље
//
//  Created by VELJKO on 19.10.22..
//

import Foundation

// MARK: - Constant for Strings
struct K {
    
    // MARK: - Eparhije Names
    struct Eparhije {
        static let zicka = "жичка"
        static let valjevska = "ваљевска"
        static let branicevska = "браничевска"
        static let raskoPrizrenska = "рашко-призренска"
    }
    
    // MARK: - Fasting View
    struct Fasting {
        
        struct Title {
            static let napomene = "Напомене"
            static let potpuniPost = "Потпуни пост"
            static let voda = "Вода"
            static let vino = "Вино"
            static let ulje = "Уље"
            static let riba = "Риба"
            static let beliMrs = "Бели мрс"
            static let buttonTitle = "Изађи"
        }
        
        struct Text {
            static let potpuniPost = "Уздржавање од хране и пића."
            static let voda = "Пост без уља и рибе."
            static let vino = "Пост на води са разрешењем једне чаше вина."
            static let ulje = "Mоже користити уље и вино."
            static let riba = "Разрешени су уље, вино и риба."
            static let beliMrs = "Може се користити све сем меса."
        }
        
    }
    
    // MARK: - App Storage
    struct AppStorage {
        static let navigationApp = "NAVIGATION_APP"
        static let userLocationDisabled = "USER_LOCATION_DISABLED"
        static let preloadedCoreData = "PRELOADED_COREDATA"
    }
    
    // MARK: - Core Data
    struct CoreData {
        static let pravoslavlje = "PravoslavljeContainer"
        
        struct Entities {
            static let manastir = "ManastirEntity"
            static let eparhija = "EparhijaEntity"
            static let month = "MonthEntity"
            static let praznik = "PraznikEntity"
        }
        
        struct Extensions {
            static let sqlite1 = "sqlite"
            static let sqlite2 = "sqlite-shm"
            static let sqlite3 = "sqlite-wal"
        }
        
        struct URLs {
            static let url1 = "/PravoslavljeContainer.sqlite"
            static let url2 = "/PravoslavljeContainer.sqlite-shm"
            static let url3 = "/PravoslavljeContainer.sqlite-wal"
            static let url4 = "/dev/null"
        }
    }
    
    // MARK: - Texts
    struct Text {
        // Navigation App Name
        struct NavigationApp {
            static let apple = "Apple"
            static let google = "Google"
        }
        // Alert Text
        struct Alerts {
            static let locationOff = "Ваша Локација је искључена. Молимо Вас да укључите локацију у опцијама."
            static let locationBlocked = "Локација блокирана."
            static let weNeedYourLocation = "Потребна је Ваша локација да би апликација успешно функционисала."
            static let goToSettings = "Иди у опције"
        }
        
        struct NavigationName {
            static let appleMaps = "Apple Maps"
            static let googleMaps = "Google Maps"
        }
        
        static let readMore = "Прочитајте више на Википедији 📚"
        static let findMonastery = "Пронађи манастир..."
    }
    
    // MARK: - Colors
    struct Colors {
        static let backgroundColor = "BackgroundColor"
        static let textColor = "TextColor"
        static let navigation = "NavigationColor"
        
        // Fasting Colors
        static let potpuniPost = "PotpuniPost"
        static let voda = "Voda"
        static let vino = "Vino"
        static let ulje = "Ulje"
        static let riba = "Riba"
        static let beliMrs = "BeliMrs"
    }
    
    // MARK: - Images
    struct Images {
        
        static let chevronRight = "chevron.right"
        static let chevronLeft = "chevron.left"
        static let infoCircle = "info.circle"
        static let eparhije = "eparhije"
        static let calendar = "calendar"
        static let map = "map.fill"
        
        
        struct Annotations {
            static let monastery = "monastery"
            static let triangle = "triangle.fill"
        }
        
        struct Navigation {
            static let navigationLogo = "navigation"
            static let apple = "appleMaps"
            static let google = "googleMaps"
        }
    }
    
    // MARK: - Fonts
    struct Fonts {
        static let clara = "Clara"
    }
}
