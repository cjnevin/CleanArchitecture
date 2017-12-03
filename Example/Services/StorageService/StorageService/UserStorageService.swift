import Foundation
import DataProvider
import Entity
import DataTransformer

public struct UserStorageService: DataProvider.UserStorageService {
	// private let storage: StorageService<User>
	
    public init() {
        
    }
    
    public func getUser() -> User? {
		// TODO: Get from Storage
        return nil
    }
    
    public func setUser(_ user: User) {
		// TODO: Store
    }
}
