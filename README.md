# Clean Architecture
My take on Uncle Bob's clean architecture in Swift.

*There are two example projects:*
- **Example** (no asynchronous events, everything returns immediately). This approach will not be useful without extending it to use closures/promises/operations or some other form of asynchronous management.
- **RxExample** (asynchronous, RxSwift, RxCocoa, Action). RxSwift is present in all layers and is considered a part of the architecture.

The workspaces are comprised of 4 main frameworks with each service having an additional framework and each platform having an additional app.

## Model (Framework)
Defines common object structure.

Examples: `Location`, `User`, `UserList`

Unit tests not needed unless files provide helper methods.

## UseCase (Framework)
Imports `Model`

Defines Interface of `DataProvider`'s

Owns business rules (or domain logic), calling `DataProvider` for information.

Examples: `GetLocationUseCase`, `GetUserListUseCase`, `GetUserDetailsUseCase`

Unit tested with mock `DataProvider`.

## DataProvider (Framework)
Imports `UseCase`

Imports `Model`

Defines Interface of `Service`'s

Defines `DTO`'s

Provides data to facilitate the use case. Maps `DTO` to and from `Model`.

Input and output of `DataProvider` methods is a `Model` object.

Input and output of `Service` interfaces is a `DTO` object.

May call multiple services to achieve goal. For example, a `UserListProvider` may check `StorageService` first before calling `ApiService`, if `ApiService` succeeds then a `UserList` is passed back to `StorageService` and the `UserList` is returned.

Example(s): `UserListProvider`, `LocationProvider`

Unit tested with mock `Service`.

## Service (Framework for each)
Imports `DataProvider`

Defines Interface of `Mapper`

Input and output of `Service` is a `DTO` object.

Implementation of a **single** service, calls `Mapper` to mutate between data type (i.e. `Realm`, `CLLocation`, `SQL`) and `DTO`.

Example(s): `ApiService`, `LocationService`, `StorageService`

Unit tested.

### Mapper (Part of each Service)
Imports `DataProvider`

Transforms data from `Service` data type to `DTO`.

There are many different ways of implementing this layer such as using a class that transforms between the objects or an extension on the object type that converts to another object type.

Examples(s): `UserJsonTransformer`, `UserRealmTransformer`, `LocationCLLocationTransformer`

Unit tested.

## Presentation (Framework)
Imports `Model`

Imports `UseCase`

### Presenter (MVP)

Defines Interface of `View`

Defines Interface of `Navigator`

Shows `Model` data from `UseCase` on `View`.

Navigates between `Presenter`'s using `Navigator`.

Example(s): `UserListPresenter`, `UserDetailPresenter`, `UserLocationPresenter`

Unit tested with mock `View` and `Navigator`.

### ViewModel (MVVM)

Defines Interface of `Navigator`

Exposes `Model` data from `UseCase` to `ViewModel`. `View` is responsible for `Rx` binding.

Exposes `Action` to navigate using `Navigator`.

Example(s): `UserListViewModel`, `UserDetailViewModel`, `UserLocationViewModel`

Unit tested with `RxTest` framework and mock `Navigator`.

## Platform (App for each)
Imports `Presentation`

Imports `Model`

Implementation of `View` interfaces defined in `Presenter`.

Implementation of `Navigator` interfaces defined in `Presenter`.

Where all of the `Service`'s/`Presenter`'s are configured for the current platform.

Example(s): `iOS`, `tvOS`, `Mac`, `Android`

UI tested/Automation with mock `Service`'s and `DataProvider`'s where necessary.

Unit testing optional.

### UseCaseFactory/Provider (Part of Platform)

Injects `...Service` into `DataProvider`.

Injects `DataProvider` into `UseCase`.

Injects `UseCase` into `Presenter`.

Provides use cases to `Presenter`.

Unit testing not necessary, no business logic exists in this framework.

### ViewFactory/Configurator (Part of Platform, one for each `View`)

Imports `UseCaseFactory`

Imports `...Service` (whatever services are necessary)

Imports `Presenter`

Injects `View` into `Presenter`.

Injects `Navigator` into `Presenter`.

Injects `UseCase` into `Presenter`.

Responsible for creating a `View`, `Presenter` and `Navigator` and configuring them.

Unit testing not necessary.
