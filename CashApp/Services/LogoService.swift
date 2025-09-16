//
//  LogoService.swift
//  AI Logo Generator
//
//  Created by Oleksii on 28.07.2025.
//

import Foundation
import UIKit
struct LogoPromptRequest: Codable {
	let prompt: String
	let color: String
	let style: String
}

struct LogoPromptResponse: Codable {
	let prompt: String
}

struct LogoGenerationRequest: Codable {
	let prompt: String
}

struct LogoGenerationResponse: Codable {
	let image_url: String
}

enum LogoServiceError: Error {
	case invalidResponse
	case serverError(String)
	case decodingError
	case networkError(Error)
}

final class LogoService {
	private let jsonDecoder = JSONDecoder()
	// MARK: - Generate Prompt
	func generatePrompt(
		prompt: String,
		color: String,
		style: String,
		completion: @escaping (Result<String, LogoServiceError>) -> Void
	) {
		guard let url = URL(string: "https://bswcwmqacecnmjfxocqu.supabase.co/functions/v1/generatePrompt") else {
			return completion(.failure(.invalidResponse))
		}

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		let body = LogoPromptRequest(prompt: prompt, color: color, style: style)
		do {
			request.httpBody = try JSONEncoder().encode(body)
		} catch {
			return completion(.failure(.decodingError))
		}

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				return completion(.failure(.networkError(error)))
			}

			guard let data = data, let http = response as? HTTPURLResponse, http.statusCode == 200 else {
				return completion(.failure(.invalidResponse))
			}

			if let decoded = try? self.jsonDecoder.decode(LogoPromptResponse.self, from: data) {
				completion(.success(decoded.prompt))
			} else if let error = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
					  let message = error["error"] as? String {
				completion(.failure(.serverError(message)))
			} else {
				completion(.failure(.decodingError))
			}
		}.resume()
	}

	// MARK: - Generate Logo
	func generateLogo(
		prompt: String,
		completion: @escaping (Result<String, LogoServiceError>) -> Void
	) {
		guard let url = URL(string: "https://bswcwmqacecnmjfxocqu.supabase.co/functions/v1/generateLogo") else {
			return completion(.failure(.invalidResponse))
		}

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		let body = LogoGenerationRequest(prompt: prompt)
		do {
			request.httpBody = try JSONEncoder().encode(body)
		} catch {
			return completion(.failure(.decodingError))
		}

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				return completion(.failure(.networkError(error)))
			}

			guard let data = data, let http = response as? HTTPURLResponse, http.statusCode == 200 else {
				return completion(.failure(.invalidResponse))
			}

			if let decoded = try? self.jsonDecoder.decode(LogoGenerationResponse.self, from: data) {
				completion(.success(decoded.image_url))
			} else if let error = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
					  let message = error["error"] as? String {
				completion(.failure(.serverError(message)))
			} else {
				completion(.failure(.decodingError))
			}
		}.resume()
	}
	
	// MARK: - Download Logo Image
	func downloadLogo(from urlString: String, completion: @escaping (Result<UIImage, LogoServiceError>) -> Void) {
		guard let url = URL(string: urlString) else {
			return completion(.failure(.invalidResponse))
		}

		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				return completion(.failure(.networkError(error)))
			}

			guard let data = data, let image = UIImage(data: data) else {
				return completion(.failure(.decodingError))
			}

			completion(.success(image))
		}

		task.resume()
	}

}
