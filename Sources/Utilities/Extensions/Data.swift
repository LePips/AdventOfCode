public extension Data {
    
    var md5: Data {
        let digest = Insecure.MD5.hash(data: self)
        return Data(digest)
    }
    
    var md5String: String {
        Insecure.MD5.hash(data: self)
            .map { String(format: "%02hhx", $0) }
            .joined()
    }
}
