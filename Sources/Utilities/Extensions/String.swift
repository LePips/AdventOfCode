public extension String {

    static let alphabet = "abcdefghijklmnopqrstuvwxyz"

    static let empty = ""

    var asInt: Int? {
        Int(self)
    }

    func count(of substring: String) -> Int {
        components(separatedBy: substring).count - 1
    }

    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))

            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch {
            fatalError("Invalid regex: \(error.localizedDescription)")
        }
    }

    func rangeMatches(for regex: String) -> [(String, ClosedRange<Int>)] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))

            return results.map {
                (String(self[Range($0.range, in: self)!]), $0.range.asClosedRange)
            }
        } catch {
            fatalError("Invalid regex: \(error.localizedDescription)")
        }
    }

    func firstMatch(for regex: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            guard let result = regex.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)) else { return nil }
            return String(self[Range(result.range, in: self)!])
        } catch {
            fatalError("Invalid regex: \(error.localizedDescription)")
        }
    }

    var reversed: String {
        String(reversed())
    }
}

public extension Substring {

    var asInt: Int? {
        asString.asInt
    }

    var asString: String {
        String(self)
    }
}
