func fetchData() async throws -> Data {
    let url = URL(string: "https://api.example.com/data")!
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }

    return data
}

Task { 
    do {
        let data = try await fetchData()
        // Process the data
    } catch {
        // Improved error handling
        switch error {
        case URLError.badServerResponse: 
            print("Server error: Check the API endpoint.")
            //Implement retry logic here if needed 
        case let URLError(code, _):
            print("Network error (code \(code)): Check your internet connection.")
        default:
            print("An unknown error occurred: \(error)")
        }
    }
}