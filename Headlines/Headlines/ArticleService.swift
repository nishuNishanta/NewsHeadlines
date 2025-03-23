import Foundation

final class ArticleService {
    private static let APIKey = "1e51dc7e-7a4d-4874-ae32-6efc9412a6a6"

    static func fetchArticles(page: Int = 1, pageSize:Int = 10) async throws -> (articles: [Article], hasMorePages: Bool ){
        let url = URL(string: "http://content.guardianapis.com/search?q=fintech&show-fields=main,body&page=\(page)&page-size=\(pageSize)&order-by=newest&api-key=\(APIKey)")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let response = try decoder.decode(GuardianAPIResponse.self, from: data)
        
        let hasMorePages = response.response.currentPage < response.response.pages
        
        return (articles: response.response.results, hasMorePages: hasMorePages)
        
    }
}

