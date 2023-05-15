import DiscordModels
import MultipartKit
import NIOCore
import Foundation

private let allocator = ByteBufferAllocator()

extension MultipartEncodable {
    /// Encodes the multipart payload into a buffer.
    /// Returns `nil` if there are no multipart data to be encoded,
    /// in which case this should be sent as JSON.
    /// Throws encoding errors.
    func encodeMultipart() throws -> ByteBuffer? {
        guard let files = self.files, !files.isEmpty else { return nil }
        
        let payload: Encodable
        if Self.rawEncodable {
            payload = self
        } else {
            payload = MultipartEncodingContainer(
                payload_json: try .init(from: self),
                files: files
            )
        }

        var buffer = allocator.buffer(capacity: 1_024)
        try FormDataEncoder().encode(
            payload,
            boundary: MultipartConfiguration.boundary,
            into: &buffer
        )

        return buffer
    }
}

enum MultipartConfiguration {
    static let boundary: String = {
        let random1 = (0..<5).map { _ in Int.random(in: 0..<10) }.map { "\($0)" }.joined()
        let random2 = (0..<5).map { _ in Int.random(in: 0..<10) }.map { "\($0)" }.joined()
        return random1 + "discordbm" + random2
    }()
}

struct MultipartEncodingContainer: Encodable {

    struct JSON: Encodable, MultipartPartConvertible {
        let buffer: ByteBuffer

        var multipart: MultipartPart? {
            MultipartPart(
                headers: ["Content-Type": "application/json"],
                body: buffer
            )
        }

        init? (multipart: MultipartPart) {
            self.buffer = multipart.body
        }

        init<E: Encodable>(from encodable: E) throws {
            let data = try DiscordGlobalConfiguration.encoder.encode(encodable)
            self.buffer = .init(data: data)
        }

        func encode(to encoder: Encoder) throws {
            let data = Data(buffer: buffer, byteTransferStrategy: .noCopy)
            var container = encoder.singleValueContainer()
            try container.encode(data)
        }
    }

    var payload_json: JSON
    var files: [RawFile]
}
