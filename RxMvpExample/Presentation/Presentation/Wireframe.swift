import Foundation
import RxSwift

private let delimiter: Character = "/"

public protocol Route {
    var source: Route? { get }
    var path: String { get }
    var uniqueId: String { get }
    var completePath: String { get }
    func navigate(animated: Bool) -> Completable
}

public extension Route {
    public var completePath: String {
        if let source = source {
            return "\(source.completePath)\(delimiter)\(path)"
        } else {
            return path
        }
    }
}

public class Wireframe {
    private var routes: [Route] = []

    public enum Error: Swift.Error {
        case routeNotFound
    }

    public init() { }

    public func add(route: Route) {
        routes.append(route)
    }

    private func routing(from route: Route, to path: String) -> [Route] {
        let components = path.split(separator: delimiter)
        let paths: [Route] = components.reduce([route], { all, candidate in
            return all + [routes.first(where: {
                $0.source?.path == all.last!.path
                        && $0.path == candidate
            })!]
        })
        return paths
    }

    public func navigate(from route: Route, to path: String, animated: Bool) -> Completable {
        debugPrint("Navigating to: \(route.completePath)/\(path)")
        return Completable.concat(routing(from: route, to: path).map {
            $0.navigate(animated: animated)
        })
    }

    public func navigate(to path: String, animated: Bool) -> Completable {
        let components = path.split(separator: delimiter)
        guard let firstComponent = components.first,
              let root = routes.first(where: { $0.source == nil && $0.path == firstComponent }) else {
            return .error(Error.routeNotFound)
        }
        return navigate(from: root,
                to: components.dropFirst().joined(separator: String(delimiter)),
                animated: animated)
    }
}
