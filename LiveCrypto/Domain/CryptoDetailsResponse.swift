//
//  CryptoDetailsResponse.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import Foundation

struct CryptoDetailsResponse: Codable {
    let id: String
    let symbol: String
    let name: String
    let webSlug: String
    let assetPlatformID: String?
    let platforms: [String: String]
    let detailPlatforms: [String: DetailPlatform]
    let blockTimeInMinutes: Int
    let hashingAlgorithm: String
    let categories: [String]
    let previewListing: Bool
    let publicNotice: String?
    let additionalNotices: [String]
    let description: Description
    let links: Links
    let image: Image
    let countryOrigin: String
    let genesisDate: String
    let sentimentVotesUpPercentage: Float
    let sentimentVotesDownPercentage: Float
    let watchlistPortfolioUsers: Int
    let marketCapRank: Int
    let communityData: CommunityData
    let statusUpdates: [String]
    let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, webSlug = "web_slug", assetPlatformID = "asset_platform_id", platforms, detailPlatforms = "detail_platforms", blockTimeInMinutes = "block_time_in_minutes", hashingAlgorithm = "hashing_algorithm", categories, previewListing = "preview_listing", publicNotice = "public_notice", additionalNotices = "additional_notices", description, links, image, countryOrigin = "country_origin", genesisDate = "genesis_date", sentimentVotesUpPercentage = "sentiment_votes_up_percentage", sentimentVotesDownPercentage = "sentiment_votes_down_percentage", watchlistPortfolioUsers = "watchlist_portfolio_users", marketCapRank = "market_cap_rank", communityData = "community_data", statusUpdates = "status_updates", lastUpdated = "last_updated"
    }
}

struct DetailPlatform: Codable {
    let decimalPlace: Int?
    let contractAddress: String
    
    enum CodingKeys: String, CodingKey {
        case decimalPlace = "decimal_place", contractAddress = "contract_address"
    }
}

struct Description: Codable {
    let en: String
}

struct Links: Codable {
    let homepage: [String]
    let whitepaper: String
    let blockchainSite: [String]
    let officialForumURL: [String]
    let chatURL: [String]
    let announcementURL: [String]
    let twitterScreenName: String
    let facebookUsername: String
    let bitcointalkThreadIdentifier: String?
    let telegramChannelIdentifier: String
    let subredditURL: String
    let reposURL: ReposURL
    
    enum CodingKeys: String, CodingKey {
        case homepage, whitepaper, blockchainSite = "blockchain_site", officialForumURL = "official_forum_url", chatURL = "chat_url", announcementURL = "announcement_url", twitterScreenName = "twitter_screen_name", facebookUsername = "facebook_username", bitcointalkThreadIdentifier = "bitcointalk_thread_identifier", telegramChannelIdentifier = "telegram_channel_identifier", subredditURL = "subreddit_url", reposURL = "repos_url"
    }
}

struct ReposURL: Codable {
    let github: [String]
    let bitbucket: [String]
}

struct Image: Codable {
    let thumb: String
    let small: String
    let large: String
}

struct CommunityData: Codable {
    let facebookLikes: Int?
    let twitterFollowers: Int
    let redditAveragePosts48h: Int
    let redditAverageComments48h: Int
    let redditSubscribers: Int
    let redditAccountsActive48h: Int
    let telegramChannelUserCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case facebookLikes = "facebook_likes", twitterFollowers = "twitter_followers", redditAveragePosts48h = "reddit_average_posts_48h", redditAverageComments48h = "reddit_average_comments_48h", redditSubscribers = "reddit_subscribers", redditAccountsActive48h = "reddit_accounts_active_48h", telegramChannelUserCount = "telegram_channel_user_count"
    }
}
